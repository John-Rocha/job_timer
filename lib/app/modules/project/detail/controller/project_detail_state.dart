part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  final ProjectViewModel? projectViewModel;
  final ProjectDetailStatus status;

  const ProjectDetailState._({
    this.projectViewModel,
    required this.status,
  });

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectViewModel? projectViewModel,
    ProjectDetailStatus? status,
  }) {
    return ProjectDetailState._(
      projectViewModel: projectViewModel ?? this.projectViewModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [projectViewModel, status];
}
