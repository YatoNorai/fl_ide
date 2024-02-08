import 'package:fl_ide/app/interactor/models/code_model.dart';

class CodeAdapter {
  static Map<String, dynamic> toMap(CodeModel code) {
    return {
      'id': code.id,
      'title': code.title,
      'code': code.code,
    };
  }

  static CodeModel fromMap(Map<String, dynamic> map) {
    return CodeModel(
      id: map['id'],
      title: map['title'],
      code: map['code'],
    );
  }
}
