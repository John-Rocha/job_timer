import 'package:flutter/material.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Input'),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Botão'),
          ),
          const Icon(
            JobTimer.ok_circled2,
            size: 50,
          )
        ],
      ),
    );
  }
}
