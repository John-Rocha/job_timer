import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;

  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectDetailState.initial());

  void setProject(ProjectViewModel projectViewModel) {
    emit(state.copyWith(
      projectViewModel: projectViewModel,
      status: ProjectDetailStatus.complete,
    ));
  }

  Future<void> updateProject() async {
    final project = await _projectService.findById(state.projectViewModel!.id!);
    emit(state.copyWith(projectViewModel: project));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectViewModel!.id!;
      await _projectService.finish(projectId);
      updateProject();
      emit(state.copyWith(status: ProjectDetailStatus.complete));
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
