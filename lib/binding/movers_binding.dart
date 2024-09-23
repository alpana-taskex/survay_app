import 'package:crew_app/modules/movers/movers_controller.dart';
import 'package:get/get.dart';

class MoversBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoversController());
  }
}
