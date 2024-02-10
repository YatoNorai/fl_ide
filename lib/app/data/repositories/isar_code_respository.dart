import 'package:fl_ide/app/interactor/models/code_model.dart';
import 'package:fl_ide/app/interactor/repositories/code_repository.dart';

class IsarCodeRepository implements CodeRepository {
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CodeModel>> getAll() async {
    // TODO: implement getAll
    return [];
  }

  @override
  Future<CodeModel> inset(CodeModel model) {
    // TODO: implement inset
    throw UnimplementedError();
  }

  @override
  Future<CodeModel> update(CodeModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
