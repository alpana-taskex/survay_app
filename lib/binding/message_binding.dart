import 'package:crew_app/modules/message/message_controller.dart';
import 'package:get/get.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>MessageController());
  }

}