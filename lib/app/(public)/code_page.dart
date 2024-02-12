import 'package:asp/asp.dart';
import 'package:fl_ide/app/(public)/config/widgets/explorer/explorer.dart';
import 'package:fl_ide/app/interactor/actions/code_action.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../themes.dart';
import 'config/widgets/code_editor/code_editor.dart';
import 'config/widgets/sidebar/sidebar.dart';

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
          appBar: AppBar(
            backgroundColor: THEMES['vs2015']!['root']?.backgroundColor,
            title: const Text(
              "FlutterIDE",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // title: Text("Recursive Fibonacci"),
            centerTitle: false,

            // toolbarHeight: 30,
            leading: Builder(
              builder: (BuildContext appBarContext) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(appBarContext).openDrawer();
                    //_controller.open(animated: true);
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),
          ),
          //backgroundColor: Colors.amber,
          body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CodeTheme(
              data: CodeThemeData(styles: THEMES['vs2015']!),
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
          drawer: SideBar(
            backgroundColor: THEMES['vs2015']!['root']?.backgroundColor,
            body: SizedBox(
              //color: Colors.blueAccent,
              width: MediaQuery.of(context).size.width * .79 - 60,
              child:
                  const Explorer(), /* Explorer(
                codeController: _codeController!,
              ), */
            ),
            child: SizedBox(
              // color: Colors.red,
              width: 60,
              //  width: MediaQuery.of(context).size.width * .7,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Bootstrap.copy),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Bootstrap.search),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Bootstrap.git),
                  ),
                  IconButton(
                    onPressed: () async {
                      /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const TerminalPage())); */
                    },
                    icon: const Icon(
                      Bootstrap.terminal,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Bootstrap.folder_x),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
