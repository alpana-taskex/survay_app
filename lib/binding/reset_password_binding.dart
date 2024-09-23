import 'package:crew_app/modules/reset_password/reset_password_controller.dart';
import 'package:crew_app/providers/auth_provider.dart';
import 'package:get/get.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> ResetPasswordController());
    Get.lazyPut(()=> AuthProvider());
  }

}