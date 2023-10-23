import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.controller});

  final TaskController controller;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  void _saveTask() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      widget.controller.registerTask(
        _nameEC.text,
        int.parse(_estimateEC.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.of(context).pop();
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar Task');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome é obrigatório'),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _estimateEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  validator:
                      Validatorless.required('Valor da duração é obrigatório'),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    onPressed: _saveTask,
                    label: 'Salvar',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
