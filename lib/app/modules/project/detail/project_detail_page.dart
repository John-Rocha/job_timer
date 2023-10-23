import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({
    super.key,
    required this.controller,
  });

  final ProjectDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
          bloc: controller,
          listener: (context, state) {
            if (state.status == ProjectDetailStatus.failure) {
              AsukaSnackbar.alert('Erro interno');
            }
          },
          builder: (context, state) {
            final projectViewModel = state.projectViewModel;

            return switch (state.status) {
              ProjectDetailStatus.initial => const Center(
                  child: Text('Carregando projeto'),
                ),
              ProjectDetailStatus.loading => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ProjectDetailStatus.failure => projectViewModel != null
                  ? _BuildProjectDetail(
                      projectViewModel: projectViewModel,
                      controller: controller,
                    )
                  : const Center(
                      child: Text('Erro ao carregar projeto'),
                    ),
              ProjectDetailStatus.complete => _BuildProjectDetail(
                  projectViewModel: projectViewModel!,
                  controller: controller,
                )
            };
          },
        ),
      ),
    );
  }
}

class _BuildProjectDetail extends StatelessWidget {
  const _BuildProjectDetail({
    required this.projectViewModel,
    required this.controller,
  });

  final ProjectViewModel projectViewModel;
  final ProjectDetailController controller;

  @override
  Widget build(BuildContext context) {
    final totalTask = projectViewModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        ProjectDetailAppbar(context, projectViewModel: projectViewModel),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
              ),
              child: ProjectPieChart(
                projectEstimate: projectViewModel.estimate,
                totalTask: totalTask,
              ),
            ),
            ...projectViewModel.tasks
                .map((task) => ProjectTaskTile(task: task))
                .toList(),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Visibility(
                visible: projectViewModel.status != ProjectStatus.finished,
                child: ElevatedButton.icon(
                  onPressed: controller.finishProject,
                  icon: const Icon(JobTimer.okCircled2),
                  label: const Text('Finalizar Projeto'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
