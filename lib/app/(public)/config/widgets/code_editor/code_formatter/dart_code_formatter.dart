import 'package:flutter/services.dart';

class DartCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String formattedText = _formatDartCode(newValue.text);

    return newValue.copyWith(text: formattedText);
  }

  String _formatDartCode(String code) {
    StringBuffer formattedCode = StringBuffer();
    int indentationLevel = 0;
    bool insideString = false;

    for (int i = 0; i < code.length; i++) {
      String char = code[i];

      if (char == '{' || char == '[' || char == '(') {
        formattedCode.write(char);
        if (i < code.length - 1 && code[i + 1] != ' ' && code[i + 1] != '\n') {
          formattedCode.writeln();
          indentationLevel++;
          formattedCode.write('\t' * indentationLevel);
        }
      } else if (char == '}' || char == ']' || char == ')') {
        indentationLevel = (indentationLevel - 1).clamp(0, indentationLevel);
        formattedCode.writeln();
        formattedCode.write('\t' * indentationLevel);
        formattedCode.write(char);
        if (i < code.length - 1 && code[i + 1] != ' ' && code[i + 1] != '\n') {
          formattedCode.write(' ');
        }
      } else if (char == '\n') {
        formattedCode.writeln();
        formattedCode.write('\t' * indentationLevel);
      } else if (char == '"' || char == "'") {
        insideString = !insideString;
        formattedCode.write(char);
      } else if (char == ',' && !insideString) {
        formattedCode.write(char);
        formattedCode.write(' ');
      } else if (char == ':') {
        formattedCode.write(char);
        formattedCode.write(' ');
      } else if (char == '=') {
        formattedCode.write(' ');
        formattedCode.write(char);
        formattedCode.write(' ');
      } else {
        formattedCode.write(char);
      }

      if (char == '{' && i == code.length - 1) {
        indentationLevel++;
        formattedCode.writeln();
        formattedCode.write('\t' * indentationLevel);
        formattedCode.write('}');
      }
    }

    return formattedCode.toString();
  }
}
