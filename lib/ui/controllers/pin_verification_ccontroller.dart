import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class PinVerificationCcontroller extends GetxController {
  bool _recoveryPinOTPInProcess = false;
  String _errorMessege = '';

  bool get recoveryPinOTPInProcess => _recoveryPinOTPInProcess;
  String get errorMessege => _errorMessege;

  Future<bool> onTapVerifyButton(String pin, String userEmail) async {
    bool isSuccess = false;
    _recoveryPinOTPInProcess = true;
    update();
    final String OTP = pin;
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.recoveryVerifyOTP(userEmail, OTP),
    );
    _recoveryPinOTPInProcess = false;
    update();

    if (response.isSuccess && response.responseData['status'] == 'success') {
      // if (mounted) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ResetPasswordScreen(
      //         userEmail: widget.userEmail,
      //         OTP: OTP,
      //       ),
      //     ),
      //   );
      // }
      isSuccess = true;
    } else {
      // if (mounted) {
      //   showSnackBarMessage(context, response.errorMsg ?? 'Failed! Try again');
      //   Navigator.pop(context);
      // }
      _errorMessege = response.errorMsg ?? 'Something went wrong';
    }
    return isSuccess;
  }
}
