import 'package:get/get.dart';
import '../modules/movers/movers_controller.dart';

class PackersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoversController());
  }
}