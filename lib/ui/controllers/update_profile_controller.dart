import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/user_data_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController {
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;
  String _errorMessage = '';

  XFile? get selectedImage => _selectedImage;
  bool get updateProfileInProgess => _updateProfileInProgress;
  String get errorMessage => _errorMessage;

  Future<void> pickProfileImage() async {
    final imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      _selectedImage = result;
      update();
    }
  }

  Future<bool> updateProfile(
      String email, String firstName, String lastName, String mobile,
      [String? password]) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    String encodedPhoto = AuthController.userData?.photo ?? '';
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodedPhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodedPhoto;
    }

    try {
      NetworkResponse response =
          await NetworkCaller.postRequest(Urls.updateProfile, requestBody);
      if (response.isSuccess && response.responseData['status'] == 'success') {
        UserModel userModel = UserModel(
          email: email,
          photo: encodedPhoto,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
        );
        await AuthController.saveUserData(userModel);
        isSuccess = true;
      } else {
        _errorMessage = response.errorMsg ?? 'Failed to update';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      debugPrint(_errorMessage);
    }

    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }
}
