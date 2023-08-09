import 'package:flutter/material.dart';

class ProjectTaskTile extends StatelessWidget {
  const ProjectTaskTile({super.key});

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
          const Text('Nome da task'),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
              text: 'Duração',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextSpan(text: '    '),
            TextSpan(
              text: '4h',
              style: TextStyle(
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
