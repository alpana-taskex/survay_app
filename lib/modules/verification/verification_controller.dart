import 'dart:async';

import 'package:crew_app/providers/auth_provider.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationController extends BaseController {
  late TextEditingController pinPutController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final provider = Get.find<AuthProvider>();
  final pinFocusNode = FocusNode();

  String email = '';
  Timer? _timer;
  RxInt timeRemaining = 60.obs;

  @override
  void onInit() {
    startTimer();
    email = Get.arguments['email'];
    super.onInit();
    pinPutController = TextEditingController();
    pinFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    pinPutController.dispose();
  }

  void verifyCode(){
    if(!formKey.currentState!.validate()) return;
    setLoading(true);
    provider.verifyCode(email, pinPutController.text).then((bool? isCodeSent) {
      if(isCodeSent==true){
        Get.toNamed(Routes.resetPassword, arguments: {'otp':pinPutController.text, 'email': email});
      }
    }).whenComplete(() => setLoading(false));
  }
  void sendVerificationCode() {
    provider.sendVerificationCode(email).then((bool? isCodeSent) {

      if(isCodeSent==true){
        startTimer();
      }
      //handle user
    });
  }

  void reSendVerificationCode() {
    isLoadingSecond.value = true;
    provider.sendVerificationCode(email).then((bool? isCodeSent) {

      if(isCodeSent==true){
        startTimer();
      }
      //handle user
    }).whenComplete(()=> isLoadingSecond.value = false);
  }

  void startTimer() async {
    timeRemaining.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value == 0) {
        disposeTimer();
      } else {
        timeRemaining.value--;
      }
    });
  }
  void disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }

}