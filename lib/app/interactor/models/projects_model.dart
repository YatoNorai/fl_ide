class ProjectsModel {
  //final int id;
  final String title;
  final String path;

  ProjectsModel({
    required this.path,
    //   required this.id,
    required this.title,
  });
  static ProjectsModel fromJson(Map<String, dynamic> json) {
    return ProjectsModel(
      // id: json['id'],
      path: json['path'],
      title: json['title'],
    );
  }
}
