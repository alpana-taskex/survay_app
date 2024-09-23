import 'package:crew_app/modules/verification/verification_controller.dart';
import 'package:get/get.dart';

class VerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(()=> VerificationController());
  }

}