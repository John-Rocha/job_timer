import 'package:flutter/material.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/widgets/new_project_task.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar(
    BuildContext context, {
    required ProjectViewModel projectViewModel,
    super.key,
  }) : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          centerTitle: true,
          title: Text(projectViewModel.name),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          flexibleSpace: Align(
            alignment: const Alignment(0, 1.6),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${projectViewModel.tasks.length} tasks'),
                      Visibility(
                        visible:
                            projectViewModel.status != ProjectStatus.finished,
                        replacement: Text(
                          'Projeto Finalizado',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        child:
                            NewProjectTask(projectViewModel: projectViewModel),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}
