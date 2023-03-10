import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/utils/texts.dart';
import 'package:getx/app/core/values/colors.dart';
import 'package:getx/app/data/models/task.dart';
import 'package:getx/app/modules/home/controller.dart';
import 'package:getx/app/core/utils/extensions.dart';
import 'package:getx/app/modules/home/widgets/add_card.dart';
import 'package:getx/app/modules/home/widgets/add_dialog.dart';
import 'package:getx/app/modules/home/widgets/task_card.dart';
import 'package:getx/app/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.wp),
                    child: labelText(
                      'My Lists',
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        // TaskCard(task: Task(title: "Hello", icon: 0xe59c, color: "#fff")),
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable<Task>(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(
                                    task: element,
                                  ),
                                ),
                                child: TaskCard(task: element),
                              ),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(
                    () => AddDialog(),
                    transition: Transition.circularReveal,
                  );
                } else {
                  EasyLoading.showInfo("Please create task type to continue.");
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Task Deleted!');
        },
      ),
    );
  }
}
