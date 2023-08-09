import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_module.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:job_timer/app/modules/project/register/project_register_module.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
            (i) => ProjectRegisterController(projectService: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/register', module: ProjectRegisterModule()),
        ModuleRoute('/detail', module: ProjectDetailModule()),
      ];
}
