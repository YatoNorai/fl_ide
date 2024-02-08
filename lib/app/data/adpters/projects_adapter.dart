import 'package:fl_ide/app/interactor/models/projects_model.dart';

class ProjectsAdapter {
  static Map<String, dynamic> toMap(ProjectsModel code) {
    return {
      //'id': code.id,
      'path': code.path,
      'title': code.title,
    };
  }

  static ProjectsModel fromMap(Map<String, dynamic> map) {
    return ProjectsModel(
      path: map['path'],
      // id: map['id'],
      title: map['title'],
    );
  }
}
