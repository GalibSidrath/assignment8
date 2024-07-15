import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProcess = false;
  String _errorMessege = '';

  bool get emailVerificationInProcess => _emailVerificationInProcess;
  String get errorMessege => _errorMessege;

  Future<bool> onTapEmailVerificationButton(String email) async {
    bool isSuccess = false;
    _emailVerificationInProcess = true;
    update();
    String userEmail = email;
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoveryEmail(userEmail));
    _emailVerificationInProcess = false;
    update();
    if (response.isSuccess) {
      // if (mounted) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PinVerificationScreen(
      //         userEmail: userEmail,
      //       ),
      //     ),
      //   );
      // }
      isSuccess = true;
    } else {
      _errorMessege = response.errorMsg ?? 'Some error occurred! Try again';
    }

    return isSuccess;
  }
}
