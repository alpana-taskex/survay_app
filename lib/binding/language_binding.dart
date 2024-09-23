import 'package:crew_app/modules/language/language_controller.dart';
import 'package:get/get.dart';

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>LanguageController());
  }

}