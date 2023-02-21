import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/utils/extensions.dart';
import 'package:getx/app/core/utils/texts.dart';
import 'package:getx/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
          child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                labelText(
                  "Completed(${homeCtrl.doneTodos.length}) ",
                  color: Colors.grey,
                  fontSize: 14.0.sp,
                ),
                ...homeCtrl.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodo(
                          element,
                        ),
                        background: Container(

                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding:  EdgeInsets.only(right: 8.0),
                            child:  Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: color,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: labelText(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
        )
        : Container());
  }
}
