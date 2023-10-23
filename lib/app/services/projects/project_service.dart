import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_model/project_task_view_model.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

abstract interface class ProjectService {
  Future<void> register(ProjectViewModel projectViewModel);
  Future<List<ProjectViewModel>> findByStatus(ProjectStatus status);
  Future<ProjectViewModel> findById(int projectId);
  Future<ProjectViewModel> addTask(
    int projectId,
    ProjectTaskViewModel taskViewModel,
  );
  Future<void> finish(int projectId);
}
