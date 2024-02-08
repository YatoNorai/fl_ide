import '../models/projects_model.dart';

abstract class ProjectsRepository {
  Future<List<ProjectsModel>> getAll();
  Future<ProjectsModel> create(ProjectsModel model);
  Future<ProjectsModel> renameFolder(ProjectsModel model);
  //  Future<ProjectsModel> renameFile(ProjectsModel model);
  Future<void> deleteFolder(String path);
  // Future<void> deleteFile(String path);
}
