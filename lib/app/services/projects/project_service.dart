import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

abstract interface class ProjectService {
  Future<void> register(ProjectViewModel projectViewModel);
  Future<List<ProjectViewModel>> findByStatus(ProjectStatus status);
}
