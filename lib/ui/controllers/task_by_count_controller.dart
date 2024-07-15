import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_status_count_model.dart';
import 'package:taskmanager/data/models/task_status_count_wrapper_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class TaskByCountController extends GetxController {
  bool _getTaskStatusByCountInProcess = false;
  List<TaskStatusCountModel> _taskCountByStutasList = [];
  String _errorMessege = '';

  bool get getTaskStatusByCountInProcess => _getTaskStatusByCountInProcess;
  List<TaskStatusCountModel> get taskCountByStutasList =>
      _taskCountByStutasList;
  String get errorMessege => _errorMessege;

  Future<bool> getTaskStatusByCount() async {
    bool isSuccess = false;
    _getTaskStatusByCountInProcess = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskStatusCountWrapperModel taskStatusCountWrapperModelModel =
          TaskStatusCountWrapperModel.fromJson(response.responseData);
      _taskCountByStutasList =
          taskStatusCountWrapperModelModel.taskStatusList ?? [];
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Faild to get task count status';
    }
    _getTaskStatusByCountInProcess = false;
    update();

    return isSuccess;
  }
}
