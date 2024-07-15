import 'package:get/get.dart';
import 'package:taskmanager/data/models/login_model.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _signInInProgress = false;
  String _errorMessege = '';
  bool get signInInProgress => _signInInProgress;
  String get errorMessege => _errorMessege;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _signInInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, requestData);

    if (response.isSuccess) {
      await AuthController.clearAllData();
      LoginModel loginModel = LoginModel.fromJson(response.responseData!);
      await AuthController.saveUserAccessToken(loginModel.token.toString());
      await AuthController.saveUserData(loginModel.userModel!);
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Signin failed! Try again';
    }

    _signInInProgress = false;
    update();

    return isSuccess;
  }
}
