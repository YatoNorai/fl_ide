import 'dart:io';

import 'package:fl_ide/app/data/adpters/projects_adapter.dart';
import 'package:fl_ide/app/interactor/models/projects_model.dart';
import 'package:fl_ide/app/interactor/repositories/projects_repository.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class IsarProjectsRepository implements ProjectsRepository {
  @override
  Future<void> deleteFolder(String path) async {
    try {
      //  print(path);
      Directory projectsDir = Directory(path);

      print(await projectsDir.exists());
      if (await projectsDir.exists()) {
        await projectsDir.delete(recursive: true);
        debugPrint('Arquivo/pasta excluído com sucesso.');
      } else {
        debugPrint('Arquivo/pasta não encontrado.');
      }
    } catch (e) {
      debugPrint('Erro ao excluir arquivo/pasta: $e');
    }
  }

  @override
  Future<List<ProjectsModel>> getAll() async {
    List<ProjectsModel> projects = [];
    Directory appSuportDir = await getApplicationSupportDirectory();
    Directory projectsDir =
        Directory('${appSuportDir.path}/home/FlutterProjects');
    List<FileSystemEntity> entities = projectsDir.listSync();
    for (var entity in entities) {
      Map<String, dynamic> titles = {
        'title': entity.path.split('/').last,
        'path': entity.path,
      };
      projects.add(ProjectsAdapter.fromMap(titles));
    }
    return projects;
  }

  @override
  Future<ProjectsModel> create(ProjectsModel model) {
    // TODO: implement inset
    throw UnimplementedError();
  }

  @override
  Future<ProjectsModel> renameFolder(ProjectsModel model) {
    // TODO: implement renameFolder
    throw UnimplementedError();
  }
}
