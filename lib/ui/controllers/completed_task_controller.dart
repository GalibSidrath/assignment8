import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_list_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProcess = false;
  String _errorMessege = '';
  List<TaskModel> _completedTaskList = [];

  bool get getCompletedTaskInProcess => _getCompletedTaskInProcess;
  List<TaskModel> get completedTaskList => _completedTaskList;
  String get errorMessege => _errorMessege;

  Future<bool> getCompletedTask() async {
    bool isSuccess = false;
    _getCompletedTaskInProcess = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _completedTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Failed to get completed task list';
    }
    _getCompletedTaskInProcess = false;
    update();
    return isSuccess;
  }
}
