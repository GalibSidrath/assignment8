import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/canceled_task_controller.dart';
import 'package:taskmanager/ui/widgets/circuler_process_indicator.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCanceledTask();
  }

  Future<void> _getCanceledTask() async {
    bool result = await Get.find<CanceledTaskController>().getCanceledTask();
    result
        ? showSnackBarMessage(context, 'All canceled task loaded')
        : showSnackBarMessage(
            context, 'Failed to fetch canceled tasks. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCanceledTask();
          },
          child: GetBuilder<CanceledTaskController>(
              builder: (canceledTaskController) {
            return Visibility(
              visible: canceledTaskController.getCanceledTaskInProcess == false,
              replacement: const CircleLoader(),
              child: ListView.builder(
                  itemCount: canceledTaskController.canceledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: canceledTaskController.canceledTaskList[index],
                      onUpdateTask: () {
                        _getCanceledTask();
                      },
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }

  // Future<void> _getCompletedTask() async {
  //   _getCanceledTaskInProcess = true;
  //   if (mounted) setState(() {});
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(Urls.canceledTask);
  //
  //   if (response.isSuccess) {
  //     TaskListWrapperModel taskListWrapperModel =
  //     TaskListWrapperModel.fromJson(response.responseData);
  //     canceledTaskList = taskListWrapperModel.taskList ?? [];
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           response.errorMsg ?? 'Failed to get Canceled Task list! Try again');
  //     }
  //   }
  //   _getCanceledTaskInProcess = false;
  //   if (mounted) setState(() {});
  // }
}
