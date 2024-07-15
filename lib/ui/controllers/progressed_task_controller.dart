import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_list_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class ProgressedTaskController extends GetxController {
  bool _getProgressedTaskInProcess = false;
  List<TaskModel> _progressedTaskList = [];
  String _errorMessege = '';

  bool get getProgressedTaskInProcess => _getProgressedTaskInProcess;
  List<TaskModel> get progressedTaskList => _progressedTaskList;
  String get errorMessege => _errorMessege;

  Future<bool> getProgressedTask() async {
    bool isSucess = false;
    _getProgressedTaskInProcess = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressedTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _progressedTaskList = taskListWrapperModel.taskList ?? [];
      isSucess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Failed to get Progressed Task List';
    }
    _getProgressedTaskInProcess = false;
    update();

    return isSucess;
  }
}
