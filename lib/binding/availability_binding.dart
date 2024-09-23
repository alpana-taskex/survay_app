import 'package:crew_app/modules/availability/availabilty_controller.dart';
import 'package:get/get.dart';


class AvailabilityBinding implements  Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => AvailabilityController());
  }
}