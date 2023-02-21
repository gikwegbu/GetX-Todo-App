import 'package:get/get.dart';
import 'package:getx/app/data/providers/task/provider.dart';
import 'package:getx/app/data/services/repository.dart';
import 'package:getx/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
