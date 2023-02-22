import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/utils/extensions.dart';
import 'package:getx/app/core/utils/texts.dart';
import 'package:getx/app/core/values/colors.dart';
import 'package:getx/app/modules/home/controller.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            var createdTasks = homeCtrl.getTotalTask();
            var completedTasks = homeCtrl.getTotalDoneTasks();
            var liveTasks = createdTasks - completedTasks;
            var percentage =
                (completedTasks / createdTasks * 100).toStringAsFixed(0);
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: labelText(
                    "My Report",
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: labelText(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.0.wp,
                    vertical: 4.0.wp,
                  ),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.wp,
                    vertical: 3.0.wp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(
                        title: 'Live Tasks',
                        number: liveTasks,
                        color: Colors.green,
                      ),
                      _buildStatus(
                        title: 'Completed',
                        number: completedTasks,
                        color: Colors.orange,
                      ),
                      _buildStatus(
                        title: 'Created Tasks',
                        number: createdTasks,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0.wp,
                ),
                UnconstrainedBox(
                  child: SizedBox(
                    width: 70.0.wp,
                    height: 70.0.wp,
                    child: CircularStepProgressIndicator(
                      totalSteps: createdTasks == 0 ? 1 : createdTasks,
                      currentStep: completedTasks,
                      stepSize: 20,
                      selectedColor: green,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 150,
                      height: 150,
                      selectedStepSize: 22,
                      roundedCap: (_, __) => true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          labelText(
                            "${createdTasks == 0 ? 0 : percentage}%",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          SizedBox(height: 1.0.wp,),
                          labelText(
                            "Efficiency",
                            color: Colors.grey,
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatus({
    required Color color,
    required int number,
    required String title,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText(
              '$number',
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
            SizedBox(
              width: 3.0.wp,
            ),
            labelText(
              title,
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.grey,
            ),
          ],
        )
      ],
    );
  }
}
