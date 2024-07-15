import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_list_wrapper_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProcess = false;
  String _errorMessege = '';
  List<TaskModel> _taskList = [];

  bool get getNewTaskInProcess => _getNewTaskInProcess;
  String get errorMessege => _errorMessege;
  List<TaskModel> get newTaskList => _taskList;

  Future<bool> getNewTask() async {
    bool isSuccess = false;
    _getNewTaskInProcess = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Failed to get New Tasks';
    }
    _getNewTaskInProcess = false;
    update();

    return isSuccess;
  }
}
