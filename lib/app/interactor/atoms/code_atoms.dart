import 'package:asp/asp.dart';
import 'package:fl_ide/app/interactor/models/code_model.dart';

import '../models/projects_model.dart';

final codeState = Atom<List<CodeModel>>([]);

final projectsState = Atom<List<ProjectsModel>>([]);
