import 'package:crew_app/modules/aboutUs/about_us_controller.dart';
import 'package:get/get.dart';

class AboutUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AboutUsController());
  }

}