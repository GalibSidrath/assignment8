import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;
  String _errorMessege = '';

  bool get addNewTaskInProgess => _addNewTaskInProgress;
  String get errorMessege => _errorMessege;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New",
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, requestData);
    _addNewTaskInProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Failed to add new task. Try again';
    }

    return isSuccess;
  }
}
