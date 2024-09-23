import 'package:crew_app/modules/forgot/forgot_controller.dart';
import 'package:crew_app/providers/auth_provider.dart';
import 'package:get/get.dart';


class ForgotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotController>(
        () => ForgotController());
    Get.lazyPut(()=> AuthProvider());

  }
}
