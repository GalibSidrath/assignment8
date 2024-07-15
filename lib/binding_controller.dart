import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanager/ui/controllers/canceled_task_controller.dart';
import 'package:taskmanager/ui/controllers/completed_task_controller.dart';
import 'package:taskmanager/ui/controllers/email_verification_controller.dart';
import 'package:taskmanager/ui/controllers/new_task_controller.dart';
import 'package:taskmanager/ui/controllers/pin_verification_ccontroller.dart';
import 'package:taskmanager/ui/controllers/progressed_task_controller.dart';
import 'package:taskmanager/ui/controllers/reset_password_controller.dart';
import 'package:taskmanager/ui/controllers/sign_in_controller.dart';
import 'package:taskmanager/ui/controllers/task_by_count_controller.dart';
import 'package:taskmanager/ui/controllers/update_profile_controller.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CanceledTaskController());
    Get.lazyPut(() => ProgressedTaskController());
    Get.lazyPut(() => TaskByCountController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => PinVerificationCcontroller());
    Get.lazyPut(() => ResetPasswordController());
  }
}
