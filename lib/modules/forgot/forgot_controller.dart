import 'package:crew_app/providers/auth_provider.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  
  

  String email = '';
  final provider = Get.find<AuthProvider>();


  @override
  void onInit() {
    super.onInit();
    focusNode.requestFocus();
  }
  void sendVerificationCode() {
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    provider.sendVerificationCode(email).then((bool? isCodeSent) {

      if(isCodeSent==true){
        Get.toNamed(Routes.verification, arguments: {'email':email});
      }
      //handle user
    }).whenComplete(() => setLoading(false));
  }
}
