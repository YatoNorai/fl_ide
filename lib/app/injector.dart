import 'package:auto_injector/auto_injector.dart';
import 'package:fl_ide/app/data/repositories/isar_code_respository.dart';
import 'package:fl_ide/app/interactor/repositories/code_repository.dart';
import 'package:fl_ide/app/interactor/repositories/projects_repository.dart';

import 'data/repositories/isar_projects_repository.dart';

final injector = AutoInjector();

void registerInstaces() {
  injector.add<CodeRepository>(IsarCodeRepository.new);
  injector.add<ProjectsRepository>(IsarProjectsRepository.new);
}
