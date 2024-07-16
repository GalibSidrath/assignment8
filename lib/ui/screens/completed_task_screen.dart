import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/completed_task_controller.dart';
import 'package:taskmanager/ui/widgets/circuler_process_indicator.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  Future<void> _getCompletedTask() async {
    bool result = await Get.find<CompletedTaskController>().getCompletedTask();
    result
        ? showSnackBarMessage(context, 'All completed task loaded')
        : showSnackBarMessage(
            context, 'Failed to fetch completed tasks. Try again');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTask();
          },
          child: GetBuilder<CompletedTaskController>(
              builder: (completedTaskController) {
            return Visibility(
              visible:
                  completedTaskController.getCompletedTaskInProcess == false,
              replacement: const CircleLoader(),
              child: ListView.builder(
                  itemCount: completedTaskController.completedTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          completedTaskController.completedTaskList[index],
                      onUpdateTask: () {
                        _getCompletedTask();
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
  //   _getCompletedTaskInProcess = true;
  //   if (mounted) setState(() {});
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTask);
  //
  //   if (response.isSuccess) {
  //     TaskListWrapperModel taskListWrapperModel =
  //     TaskListWrapperModel.fromJson(response.responseData);
  //     completedTaskList = taskListWrapperModel.taskList ?? [];
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           response.errorMsg ?? 'Failed to get Completed Task list! Try again');
  //     }
  //   }
  //   _getCompletedTaskInProcess = false;
  //   if (mounted) setState(() {});
  // }
}
