import 'package:fl_ide/app/injector.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:fl_ide/app/interactor/models/code_model.dart';
import 'package:fl_ide/app/interactor/repositories/code_repository.dart';

Future<void> fecthCode() async {
  final repository = injector.get<CodeRepository>();
  codeState.value = await repository.getAll();
}

Future<void> putCode(CodeModel model) async {
  final repository = injector.get<CodeRepository>();
  if (model.id == -1) {
    await repository.inset(model);
    // create
  } else {
    //update
    await repository.update(model);
  }
  //reload list
  fecthCode();
}

Future<void> deleteCode(int id) async {
  final repository = injector.get<CodeRepository>();
  await repository.delete(id);
  fecthCode();
}
