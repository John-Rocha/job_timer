import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.projectModel});

  final ProjectViewModel projectModel;

  Future<void> _diplayBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * .45,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed(
          '/project/detail/',
          arguments: projectModel,
        );
        Modular.get<HomeController>().updateList();
      },
      onLongPress: () => _diplayBottomSheet(context),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 4,
          ),
        ),
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            Expanded(
              child: _ProjectProgress(
                projectModel: projectModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectViewModel projectModel;

  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            projectModel.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Icon(
            JobTimer.angleDoubleRight,
            color: Theme.of(context).primaryColor,
            size: 20,
          )
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectViewModel projectModel;

  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks
        .fold(0, (previousValue, task) => previousValue += task.duration);

    double percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[400]!,
              color: Theme.of(context).primaryColor,
              value: percent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectModel.estimate}h'),
          )
        ],
      ),
    );
  }
}
