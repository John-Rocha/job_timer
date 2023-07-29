import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';

abstract interface class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
}
