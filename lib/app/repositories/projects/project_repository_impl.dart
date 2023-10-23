import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();

      await connection.writeTxn(() {
        return connection.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar o projeto', error: e, stackTrace: s);
      throw Failure(errorMessage: 'Erro ao cadastrar o projeto');
    }
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);

    if (project == null) {
      throw Failure(errorMessage: 'Projeto não encontrado');
    }
    return project;
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();

    return connection.projects.filter().statusEqualTo(status).findAll();
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final project = await findById(projectId);

    await connection.writeTxn(() async {
      await connection.projectTasks.put(task);
      project.tasks.add(task);
      return project.tasks.save();
    });

    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);

      project.status = ProjectStatus.finished;

      await connection.writeTxn(() => connection.projects.put(project));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(errorMessage: 'Erro ao finalizar projeto');
    }
  }
}
