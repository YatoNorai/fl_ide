import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:rubber/rubber.dart';

import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../../../../themes.dart';
import '../code_theme/code_theme_data.dart';
import '../componets/custom_context_menu.dart';
import '../componets/custom_magnifier.dart';
import '../line_numbers/line_number_controller.dart';
import '../line_numbers/line_number_style.dart';
import 'code_auto_complete.dart';
import 'code_controller.dart';

class CodeField extends StatefulWidget {
  /// {@macro flutter.widgets.textField.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro flutter.widgets.textField.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro flutter.widgets.textField.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.textField.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.textField.maxLInes}
  final int? maxLines;

  /// {@macro flutter.widgets.textField.expands}
  final bool expands;

  /// Whether overflowing lines should wrap around or make the field scrollable horizontally
  final bool wrap;

  /// A CodeController instance to apply language highlight, themeing and modifiers
  final CodeController controller;

  /// a undo redo controller
  final UndoHistoryController? undoHistoryController;

  /// A LineNumberStyle instance to tweak the line number column styling
  final LineNumberStyle lineNumberStyle;

  /// {@macro flutter.widgets.textField.cursorColor}
  final Color? cursorColor;

  /// {@macro flutter.widgets.textField.textStyle}
  final TextStyle? textStyle;

  /// A way to replace specific line numbers by a custom TextSpan
  final TextSpan Function(int, TextStyle?)? lineNumberBuilder;

  /// {@macro flutter.widgets.textField.enabled}
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.onChanged}
  final void Function(String)? onChanged;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.textField.isDense}
  final bool isDense;

  /// {@macro flutter.widgets.textField.selectionControls}
  final TextSelectionControls? selectionControls;

  final Color? background;
  final EdgeInsets padding;
  final Decoration? decoration;
  final TextSelectionThemeData? textSelectionTheme;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final bool lineNumbers;
  final bool horizontalScroll;
  final String? hintText;
  final TextStyle? hintStyle;
  final CodeAutoComplete? autoComplete;

  const CodeField({
    super.key,
    required this.controller,
    this.undoHistoryController,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.wrap = false,
    this.background,
    this.decoration,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.lineNumberStyle = const LineNumberStyle(),
    this.enabled,
    this.onTap,
    this.readOnly = false,
    this.cursorColor,
    this.textSelectionTheme,
    this.lineNumberBuilder,
    this.focusNode,
    this.onChanged,
    this.isDense = false,
    this.smartQuotesType,
    this.smartDashesType,
    this.keyboardType,
    this.lineNumbers = true,
    this.horizontalScroll = true,
    this.selectionControls,
    this.hintText,
    this.hintStyle,
    this.autoComplete,
  });

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> with TickerProviderStateMixin {
  // Add a controller
  LinkedScrollControllerGroup? _controllers;
  bool blockScroll = false;
  late final ScrollController _verticalController = ScrollController();
  late final ScrollController _horizontalController = ScrollController();
  ScrollController? _numberScroll;
  ScrollController? _codeScroll;
  late RubberAnimationController _rubberAnimationController;
  LineNumberController? _numberController;
  bool isZoom = false;

  StreamSubscription<bool>? _keyboardVisibilitySubscription;
  FocusNode? _focusNode;
  String? lines;
  String longestLine = '';

  @override
  void initState() {
    super.initState();
    _rubberAnimationController = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 1.0),
        halfBoundValue: AnimationControllerValue(percentage: 0.35),
        lowerBoundValue: AnimationControllerValue(pixel: 80),
        duration: const Duration(milliseconds: 200));
    // _rubberAnimationController.addStatusListener(_statusListener);
    // _rubberAnimationController.animationState.addListener(_stateListener);
    _controllers = LinkedScrollControllerGroup();
    _numberScroll = _controllers?.addAndGet();
    _codeScroll = _controllers?.addAndGet();
    _numberController = LineNumberController(widget.lineNumberBuilder);
    widget.controller.addListener(_onTextChanged);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.onKey = _onKey;
    _focusNode!.attach(context, onKey: _onKey);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      createAutoComplate();
    });

    _onTextChanged();
  }

  void createAutoComplate() {
    if (widget.autoComplete != null) {
      widget.autoComplete?.show(context, widget, _focusNode!);
      widget.controller.autoComplete = widget.autoComplete;
      _codeScroll?.addListener(hideAutoComplete);
    }
  }

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    if (widget.readOnly) {
      return KeyEventResult.ignored;
    }

    return widget.controller.onKey(event);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _numberScroll?.dispose();
    _codeScroll?.dispose();
    _numberController?.dispose();
    _keyboardVisibilitySubscription?.cancel();
    widget.autoComplete?.remove();
    super.dispose();
  }

  void rebuild() {
    setState(() {});
  }

  void _onTextChanged() {
    // Rebuild line number
    final str = widget.controller.text.split('\n');
    final buf = <String>[];

    for (var k = 0; k < str.length; k++) {
      buf.add((k + 1).toString());
    }

    _numberController?.text = buf.join('\n');

    // Find longest line
    longestLine = '';
    widget.controller.text.split('\n').forEach((line) {
      if (line.length > longestLine.length) longestLine = line;
    });

    setState(() {});
  }

  //coemment lines

  void _commentSelectedLines() {
    setState(() {
      // Get the selected text and add "//" at the beginning of each line
      String selectedText = _getSelectedText();
      String commentedText =
          selectedText.split('\n').map((line) => '// $line').join('\n');

      // Replace the selected text with the commented text
      widget.controller.text = widget.controller.text.replaceRange(
        widget.controller.selection.start,
        widget.controller.selection.end,
        commentedText,
      );
    });
  }

  String _getSelectedText() {
    int start = widget.controller.selection.start;
    int end = widget.controller.selection.end;
    return widget.controller.text.substring(start, end);
  }

  /// caculate row width
  int calculateValue() {
    int textLength = _numberController!.value.text.length;

    if (textLength >= 1000) {
      return 60;
    } else if (textLength >= 100) {
      return 30;
    } else if (textLength >= 10) {
      return 20;
    } else {
      return 20; // Valor padrão se o comprimento for menor que 10
    }
  }

  // Wrap the codeField in a horizontal scrollView
  Widget _wrapInScrollView(
    Widget codeField,
    TextStyle textStyle,
    double minWidth,
  ) {
    final leftPad = widget.lineNumberStyle.margin / 1.5;
    var intrinsic = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*  ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0,
              minWidth: max(minWidth - leftPad, 0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
              ),
              child: Text(longestLine, style: textStyle),
            ), // Add extra padding
          ), */
          Expanded(child: codeField)
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        // left: 10,

        left: leftPad,
        right: widget.padding.right,
      ),
      child: intrinsic,
    );
  }

  void removeAutoComplete() {
    widget.autoComplete?.remove();
  }

  void hideAutoComplete() {
    widget.autoComplete?.hide();
  }

  @override
  Size get preferredSize => Size(
      250,
      // 2 is border size
      min(26 * _numberController!.value.text.length, 200) + 2);

  @override
  Widget build(BuildContext context) {
    List<String> sheetHeader = [
      '->',
      '(',
      ')',
      '{',
      '}',
      '[',
      ']',
      ';',
      '==',
      '<=',
      '>=',
      '"',
      ':',
      ';',
      '=',
      '+',
      '-',
      '*',
      '/',
      '%',
      '&',
      '|',
      '^',
      '!',
      '?',
      '<',
      '>',
    ];
    // Default color scheme
    const rootKey = 'root';
    final defaultBg = Colors.grey.shade900;
    final defaultText = Colors.grey.shade200;

    final styles = CodeTheme.of(context)?.styles;
    Color? backgroundCol =
        widget.background ?? styles?[rootKey]?.backgroundColor ?? defaultBg;

    if (widget.decoration != null) {
      backgroundCol = null;
    }

    TextStyle textStyle = widget.textStyle ?? const TextStyle();
    textStyle = textStyle.copyWith(
      color: textStyle.color ?? styles?[rootKey]?.color ?? defaultText,
      fontSize: textStyle.fontSize ?? 16.0,
    );

    TextStyle numberTextStyle =
        widget.lineNumberStyle.textStyle ?? const TextStyle();
    final numberColor =
        (styles?[rootKey]?.color ?? defaultText).withOpacity(0.7);

    // Copy important attributes
    numberTextStyle = numberTextStyle.copyWith(
      color: numberTextStyle.color ?? numberColor,
      fontSize: textStyle.fontSize,
      fontFamily: textStyle.fontFamily,
    );

    final cursorColor =
        widget.cursorColor ?? styles?[rootKey]?.color ?? defaultText;

    TextField? lineNumberCol;
    Container? numberCol;

    if (widget.lineNumbers) {
      lineNumberCol = TextField(
        smartQuotesType: widget.smartQuotesType,
        smartDashesType: widget.smartDashesType,
        scrollPadding: widget.padding,
        style: numberTextStyle,
        controller: _numberController,
        undoController: widget.undoHistoryController,
        enabled: false,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        selectionControls: widget.selectionControls,
        expands: widget.expands,
        scrollController: _numberScroll,
        decoration: InputDecoration(
          disabledBorder: InputBorder.none,
          isDense: widget.isDense,
        ),
        textAlign: widget.lineNumberStyle.textAlign,
      );

      numberCol = Container(
        width: calculateValue().toDouble(), //widget.lineNumberStyle.width,
        color: widget.lineNumberStyle.background,
        child: lineNumberCol,
      );
    }

    final codeField = TextFormField(
      keyboardType: widget.keyboardType,
      smartQuotesType: widget.smartQuotesType,
      smartDashesType: widget.smartDashesType,
      focusNode: _focusNode,
      onTap: () {
        widget.autoComplete?.hide();
        widget.onTap?.call();
      },
      enableInteractiveSelection: true,
      contextMenuBuilder: (context, editableTextState) {
        return CustomContextMenu(
          editableTextState: editableTextState,
          backgroundColor: Colors.grey[700]!,
          disabledColor: Colors.transparent,
          borderRadius: 20,
          buttonPadding: 00,
          textStyle: const TextStyle(color: Colors.white),
          onCommentSelected: _commentSelectedLines,
        );
      },
      magnifierConfiguration: TextMagnifierConfiguration(
        magnifierBuilder: (_, __, ValueNotifier<MagnifierInfo> magnifierInfo) =>
            CustomMagnifier(
          magnifierInfo: magnifierInfo,
        ),
      ),
      scrollPadding: widget.padding,
      style: textStyle,
      controller: widget.controller,
      undoController: widget.undoHistoryController,
      minLines: widget.minLines,
      selectionControls: widget.selectionControls,
      maxLines: widget.maxLines,
      expands: widget.expands,
      scrollController: _codeScroll,
      decoration: InputDecoration(
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: widget.isDense,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
      ),
      onTapOutside: (e) {
        Future.delayed(const Duration(milliseconds: 300), hideAutoComplete);
      },
      cursorColor: cursorColor,
      autocorrect: false,
      enableSuggestions: false,
      enabled: widget.enabled,
      onChanged: (text) {
        widget.onChanged?.call(text);
        widget.autoComplete?.streamController.add(text);
      },
      readOnly: widget.readOnly,
      inputFormatters: const [
        //  LengthLimitingTextInputFormatter(10000),
        //  DartCodeFormatter(),
      ],
    );

    final codeCol = Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: widget.textSelectionTheme,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Control horizontal scrolling
          return widget.wrap
              ? codeField
              : _wrapInScrollView(codeField, textStyle, constraints.maxHeight);
        },
      ),
    );

    return RubberBottomSheet(
      dragFriction: 1.0,
      headerHeight: 60,
      animationController: _rubberAnimationController,
      header: Container(
        decoration: BoxDecoration(
          color: THEMES['tomorrow-night-blue']!['root']?.backgroundColor,
          border: Border(
            top: BorderSide(
              color: Colors.grey[600]!,
            ),
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.horizontal,
          itemCount: sheetHeader.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () {
                    if (sheetHeader[index] == '(') {
                      widget.controller.text += '()';
                      int offset = (widget.controller.text
                                  .lastIndexOf(sheetHeader[index]) +
                              sheetHeader[index].length) ~/
                          1;
                      widget.controller.selection =
                          TextSelection.collapsed(offset: offset);
                    } else if (sheetHeader[index] == '{') {
                      widget.controller.text += '{}';
                      int offset = (widget.controller.text
                                  .lastIndexOf(sheetHeader[index]) +
                              sheetHeader[index].length) ~/
                          1;
                      widget.controller.selection =
                          TextSelection.collapsed(offset: offset);
                    } else if (sheetHeader[index] == '[') {
                      widget.controller.text += '[]';
                      int offset = (widget.controller.text
                                  .lastIndexOf(sheetHeader[index]) +
                              sheetHeader[index].length) ~/
                          1;
                      widget.controller.selection =
                          TextSelection.collapsed(offset: offset);
                    } else {
                      widget.controller.text += sheetHeader[index];
                    }
                  },
                  child: Text(sheetHeader[index])),
            );
          },
        ),
      ),
      lowerLayer: Scrollbar(
        interactive: true,
        trackVisibility: true,
        thickness: 8,
        controller: _horizontalController,
        child: Scrollbar(
          interactive: true,
          trackVisibility: true,
          thickness: 8,
          controller: _verticalController,
          child: TableView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            horizontalDetails: ScrollableDetails.horizontal(
              controller: _horizontalController,
            ),
            verticalDetails: ScrollableDetails.vertical(
              controller: _verticalController,
            ),
            cellBuilder: (BuildContext context, TableVicinity vicinity) {
              return Container(
                decoration: widget.decoration,
                color: backgroundCol,
                padding:
                    !widget.lineNumbers ? const EdgeInsets.only(left: 8) : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //   if (widget.lineNumbers && numberCol != null) numberCol,
                    if (vicinity.column.isEven) numberCol! else codeCol,
                  ],
                ),
              );
            },
            columnCount: 2,
            columnBuilder: (int index) {
              switch (index) {
                case 0:
                  return TableSpan(
                    foregroundDecoration: TableSpanDecoration(
                      consumeSpanPadding: true,
                      //color: Colors.purple[100],
                      border: TableSpanBorder(
                        trailing: BorderSide(
                          color: Colors.grey[700]!,
                          width: 0.5,
                        ),
                      ),
                    ),
                    extent: FixedTableSpanExtent(calculateValue().toDouble()),
                    /*  onEnter: (_) => print('Entered column $index'),
                      recognizerFactories: <Type, GestureRecognizerFactory>{
                        TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                            TapGestureRecognizer>(
                          () => TapGestureRecognizer(),
                          (TapGestureRecognizer t) =>
                              t.onTap = () => print('Tap column $index'),
                        ),
                      }, */
                  );
                case 1:
                  return const TableSpan(
                    // foregroundDecoration: decoration,
                    extent: FractionalTableSpanExtent(2.8),
                    //  onEnter: (_) => print('Entered column $index'),
                    //  cursor: SystemMouseCursors.contextMenu,
                  );
              }
              throw AssertionError(
                  'This should be unreachable, as every index is accounted for in the switch clauses.');
            },
            rowCount: 1,
            rowBuilder: (int index) {
              /// print(_numberController!.value.text.length / 23);
              switch (index) {
                case 0:
                  return TableSpan(
                    //  backgroundDecoration: decoration,
                    extent: FractionalTableSpanExtent(preferredSize.height),
                    /* recognizerFactories: <Type, GestureRecognizerFactory>{
                        TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                            TapGestureRecognizer>(
                          () => TapGestureRecognizer(),
                          (TapGestureRecognizer t) =>
                              t.onTap = () => print('Tap row $index'),
                        ),
                      }, */
                  );
              }
              throw AssertionError(
                  'This should be unreachable, as every index is accounted for in the switch clauses.');
            },
            pinnedColumnCount: 1,
            diagonalDragBehavior: DiagonalDragBehavior.free,
          ),
        ),
      ),
      upperLayer: Container(
          color: THEMES['tomorrow-night-blue']!['root']?.backgroundColor),
    );
  }
}
