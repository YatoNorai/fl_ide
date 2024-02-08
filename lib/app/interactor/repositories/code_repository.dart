import 'package:fl_ide/app/interactor/models/code_model.dart';

abstract class CodeRepository {
  Future<List<CodeModel>> getAll();
  Future<CodeModel> inset(CodeModel model);
  Future<CodeModel> update(CodeModel model);
  Future<bool> delete(int id);
}
