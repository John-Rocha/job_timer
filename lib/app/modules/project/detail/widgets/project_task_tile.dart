import 'package:flutter/material.dart';
import 'package:job_timer/app/view_model/project_task_view_model.dart';

class ProjectTaskTile extends StatelessWidget {
  const ProjectTaskTile({super.key, required this.task});

  final ProjectTaskViewModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task.name),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
              text: 'Duração',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const TextSpan(text: '    '),
            TextSpan(
              text: '${task.duration}h',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
