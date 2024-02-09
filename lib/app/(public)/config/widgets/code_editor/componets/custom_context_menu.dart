library custom_context_menu;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContextMenu extends StatelessWidget {
  const CustomContextMenu({
    super.key,
    required this.editableTextState,
    required this.backgroundColor,
    required this.disabledColor,
    required this.borderRadius,
    required this.buttonPadding,
    required this.textStyle,
    required this.onCommentSelected,
  });

  final EditableTextState editableTextState;
  final Color backgroundColor;
  final Color disabledColor;
  final double borderRadius;
  final double buttonPadding;
  final TextStyle textStyle;
  final VoidCallback onCommentSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AdaptiveTextSelectionToolbar(
          anchors: editableTextState.contextMenuAnchors,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              //   padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      editableTextState.selectAll(SelectionChangedCause.tap);
                    },
                    icon: const Icon(
                      Icons.select_all_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editableTextState.cutSelection(SelectionChangedCause.tap);
                    },
                    icon: const Icon(
                      Icons.cut_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      editableTextState
                          .copySelection(SelectionChangedCause.tap);
                    },
                    icon: const Icon(
                      Icons.copy_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ///  editableTextState.hideMagnifier();
                      editableTextState.pasteText(SelectionChangedCause.tap);
                    },
                    icon: const Icon(
                      Icons.paste_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: onCommentSelected
                    //   editableTextState.pasteText(SelectionChangedCause.tap);
                    ,
                    icon: const Icon(
                      Icons.code_off_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  /*  IconButton(
                    onPressed: () {
                      editableTextState
                          .lookUpSelection(SelectionChangedCause.tap);
                    },
                    icon: Icon(
                      Icons.paste_rounded,
                      size: 18,
                    ),
                  ), */
                ],
              ),
            ),
          ]

          /* editableTextState.contextMenuButtonItems
            .map((ContextMenuButtonItem buttonItem) {
          return Container(
            //padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              // color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
            ),
            child: CupertinoButton(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: backgroundColor,
              disabledColor: disabledColor,
              onPressed: buttonItem.onPressed,
              padding: const EdgeInsets.all(10.0),
              pressedOpacity: 0.7,
              child: Container(
                padding: EdgeInsets.all(buttonPadding),
                child: Text(
                  CupertinoTextSelectionToolbarButton.getButtonLabel(
                      context, buttonItem),
                  style: textStyle,
                ),
              ),
            ),
          );
        }).toList(), */
          ),
    );
  }
}
