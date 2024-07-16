import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/progressed_task_controller.dart';
import 'package:taskmanager/ui/widgets/circuler_process_indicator.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class ProgressedTaskScreen extends StatefulWidget {
  const ProgressedTaskScreen({super.key});

  @override
  State<ProgressedTaskScreen> createState() => _ProgressedTaskScreenState();
}

class _ProgressedTaskScreenState extends State<ProgressedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  Future<void> _getProgressTask() async {
    bool result =
        await Get.find<ProgressedTaskController>().getProgressedTask();
    result
        ? showSnackBarMessage(context, 'All progressed task loaded')
        : showSnackBarMessage(
            context, 'Failed to fetch progressed tasks. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getProgressTask();
          },
          child: GetBuilder<ProgressedTaskController>(
              builder: (progressedTaskController) {
            return Visibility(
              visible:
                  progressedTaskController.getProgressedTaskInProcess == false,
              replacement: const CircleLoader(),
              child: ListView.builder(
                  itemCount: progressedTaskController.progressedTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          progressedTaskController.progressedTaskList[index],
                      onUpdateTask: () {
                        _getProgressTask();
                      },
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }

  // Future<void> _getProgressedTask() async {
  //   _getProgressedTaskInProcess = true;
  //   if (mounted) setState(() {});
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(Urls.progressedTask);
  //
  //   if (response.isSuccess) {
  //     TaskListWrapperModel taskListWrapperModel =
  //     TaskListWrapperModel.fromJson(response.responseData);
  //     progressedTaskList = taskListWrapperModel.taskList ?? [];
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           response.errorMsg ?? 'Failed to get Progressed Task list! Try again');
  //     }
  //   }
  //   _getProgressedTaskInProcess = false;
  //   if (mounted) setState(() {});
  // }
}
