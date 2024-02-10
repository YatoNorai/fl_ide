import 'package:asp/asp.dart';
import 'package:fl_ide/app/interactor/actions/code_action.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:flutter/material.dart';

import '../../themes.dart';
import 'config/widgets/code_editor/code_editor.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  CodeController? _codeController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeController = CodeController(
      modifiers: [const TabModifier(), const IndentModifier()],
      text: '''codeanjnfasamkaaavlavavmaapvavvmvppmavmavmvmpavmavmavmvmam
      lspvpvpvpa
      afakpa,v,a
      avkvavavapv
      amvmamvav''', //CODE_SNIPPETS['dart'],
      // patternMap: patters_maps,
      // stringMap: stringMap,
      //  language: allLanguages['dart'],
    );
    fecthCode();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (BuildContext context) {
        final codes = codeState.value;
        return Scaffold(
          //backgroundColor: Colors.amber,
          body: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: CodeTheme(
              data: CodeThemeData(styles: THEMES['tomorrow-night-blue']!),
              child: CodeField(
                // undoHistoryController: _undoController,
                controller: _codeController!,
                //    autoComplete: autoComplete,
                wrap: false,
                horizontalScroll: false,
                lineNumbers: true,
                isDense: true,
                lineNumberStyle: const LineNumberStyle(
                    margin: 5, textAlign: TextAlign.center, width: 20),
                textStyle: const TextStyle(fontSize: 14),
                /*   textStyle: TextStyle(
                                  fontFamily: 'FiraCode', fontSize: fontSize), */
              ),
            ),
          ),
        );
      },
    );
  }
}
