import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_projects_menu.dart';
import 'package:job_timer/app/modules/home/widgets/project_tile.dart';
import 'package:job_timer/app/view_model/project_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao buscar os projetos').show();
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: ListTile(
              title: const Text('Sair'),
              onTap: () {},
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                floating: true,
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(controller: controller),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) => state.status == HomeStatus.loading,
                builder: (context, showLoading) => SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    )),
              ),
              BlocSelector<HomeController, HomeState, List<ProjectViewModel>>(
                bloc: controller,
                selector: (state) => state.projects,
                builder: (context, projetcs) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      projetcs
                          .map((project) => ProjectTile(projectModel: project))
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
