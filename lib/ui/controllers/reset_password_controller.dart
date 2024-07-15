import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class ResetPasswordController extends GetxController {
  bool _confirmNewPasswordInProcess = false;
  String _errorMessege = '';

  bool get confirmNewPasswordInProcess => _confirmNewPasswordInProcess;
  String get errorMessege => _errorMessege;

  Future<bool> onTapConfirmButton(
      String email, String otp, String newPassword) async {
    bool isSuccess = false;
    _confirmNewPasswordInProcess = true;
    update();
    Map<String, dynamic> requestData = {
      "email": email,
      "OTP": otp,
      "password": newPassword,
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.recoverResetPass, requestData);
    if (response.isSuccess) {
      // if (mounted) {
      //   showSnackBarMessage(context, 'Password reset successful');
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => const SignInScreen()),
      //           (route) => false);
      // }
      isSuccess = true;
    } else {
      // if (response.isSuccess) {
      //   if (mounted) {
      //     showSnackBarMessage(
      //         context, response.errorMsg ?? 'Failed! Try again');
      //   }
      // }
      _errorMessege = response.errorMsg ?? 'Failed! Try again';
    }
    _confirmNewPasswordInProcess = false;
    update();

    return isSuccess;
  }
}
