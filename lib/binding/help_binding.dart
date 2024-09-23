import 'package:crew_app/modules/help/help_controller.dart';
import 'package:get/get.dart';

class HelpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>HelpController());
  }

}