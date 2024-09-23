import 'package:crew_app/modules/reset_password/reset_password.dart';
import 'package:crew_app/providers/auth_provider.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends BaseController {
  final formKey = GlobalKey<FormState>();
  RxBool showOldPassword = false.obs;
  RxBool showNewPassword = false.obs;
  String password = '';
  String? otp;
  String? email;
  final provider = Get.find<AuthProvider>();

  @override
  void onInit() {
    super.onInit();
    otp = Get.arguments['otp'];
    email = Get.arguments['email'];
  }

  void resetPassword() {
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    final body = {
      if(otp != null) 'email':email!,
      if(otp != null) 'otp':otp!,
      'password':password
    };
    provider.changePassword(body).then((bool isVerified) {
      if(isVerified){
        showPasswordChangedDialog();
      }

    }).whenComplete(() =>setLoading(false));
  }
}