import 'package:crew_app/models/user_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/auth_provider.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  // late final AnimationController controller;
  String Name = '', password = '';

  RxBool showPassword = false.obs;

  final provider = Get.find<AuthProvider>();

  void login() {
    if (!formKey.currentState!.validate()) return;
    showLoader();
    provider.login(Name, password).then((User? user) {
      if (user != null) {
        final box = GetStorage();
        Constants.user = user;
        Constants.token = user.authToken;
        box.write('username', user.toJson());
        box.write('token', user.authToken);
        Get.offAllNamed(Routes.home);
      }
    }).whenComplete(hideLoader);
  }
}
