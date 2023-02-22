import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/utils/extensions.dart';
import 'package:getx/app/core/utils/texts.dart';
import 'package:getx/app/core/values/colors.dart';
import 'package:getx/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Get.back();
                        homeCtrl.editCtrl.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if(homeCtrl.formKey.currentState!.validate()) {
                          if(homeCtrl.task.value == null) {
                            EasyLoading.showError("Please select task type");
                          }else  {
                            var success = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.editCtrl.text,
                            );
                            if(success) {
                              EasyLoading.showSuccess("Todo Added 📝", maskType: EasyLoadingMaskType.black);
                              Get.back();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError("Todo item already exist");
                            }
                            homeCtrl.editCtrl.clear();
                          }
                        }
                      },
                      child: labelText(
                        'Done',
                        fontSize: 14.0.sp,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: labelText(
                  "New Task",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return "Field cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0.wp,
                  left: 5.0.wp,
                  bottom: 5.0.wp,
                  right: 5.0.wp,
                ),
                child: labelText(
                  "Add to",
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
              ...homeCtrl.tasks
                  .map(
                    (element) => Obx(() =>
                      InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0.wp, vertical: 3.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon, fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  labelText(
                                    element.title,
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              if (homeCtrl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
