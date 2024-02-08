import 'package:fl_ide/app/injector.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:fl_ide/app/interactor/models/projects_model.dart';
import 'package:fl_ide/app/interactor/repositories/projects_repository.dart';

Future<void> fecthProjects() async {
  final repository = injector.get<ProjectsRepository>();
  projectsState.value = await repository.getAll();
}

Future<void> putProjects(ProjectsModel model) async {
  final repository = injector.get<ProjectsRepository>();
  /*  if (model.id == -1) { */
  await repository.create(model);
  // create
/*   } else {
    //update
    await repository.update(model);
  } */
  //reload list
  fecthProjects();
}

Future<void> deleteProjectsFolder(String path) async {
  final repository = injector.get<ProjectsRepository>();
  await repository.deleteFolder(path);
  fecthProjects();
}

Future<void> deleteProjectsRenameFolder(String path) async {
  final repository = injector.get<ProjectsRepository>();

  fecthProjects();
}
