import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/utils/extensions.dart';
import 'package:getx/app/core/utils/imageUtils.dart';
import 'package:getx/app/core/utils/texts.dart';
import 'package:getx/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
            ? Column(
                children: [
                  Image.asset(
                    ImageUtils.emptyTodoState,
                    fit: BoxFit.cover,
                    width: 65.0.wp,
                  ),
                  labelText(
                    "Add Task",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                ],
              )
            : ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...homeCtrl.doingTodos
                      .map(
                        (element) => CheckboxListTile(
                          visualDensity: VisualDensity.compact,
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.red,
                          activeColor: Colors.blue,
                          value: element['done'],
                          onChanged: (val) {
                            homeCtrl.doneTodo(element['title']);
                            EasyLoading.showSuccess(
                                "${element['title']} Completed!",
                                maskType: EasyLoadingMaskType.black);
                          },
                          title: labelText(
                            element['title'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  if (homeCtrl.doingTodos.isNotEmpty)
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: const Divider(
                        thickness: 2,

                      ),
                    ),
                ],
              );
      },
    );
  }
}
