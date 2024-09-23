import 'package:crew_app/modules/login/login_controller.dart';
import 'package:crew_app/providers/auth_provider.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController());
    Get.lazyPut<AuthProvider>(
        () => AuthProvider());
  }
}
