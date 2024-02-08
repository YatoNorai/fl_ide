import 'package:asp/asp.dart';
import 'package:fl_ide/app/interactor/actions/code_action.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:flutter/material.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthCode();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (BuildContext context) {
        final codes = codeState.value;
        return Scaffold(
          backgroundColor: Colors.amber,
          body: ListView.builder(
            itemCount: codes.length,
            itemBuilder: (_, index) {
              final code = codes[index];
              return ListTile(
                title: Text(code.title),
                subtitle: Text(
                  code.code,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
