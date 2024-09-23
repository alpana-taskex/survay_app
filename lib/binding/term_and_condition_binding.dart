import 'package:crew_app/modules/term_and_condition/term_and_condition_controller.dart';
import 'package:get/get.dart';

class TermAndConditionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>TermAndConditionController());
  }

}