import 'package:crew_app/modules/notification/notification_controller.dart';
import 'package:crew_app/providers/notification_provider.dart';
import 'package:get/get.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>NotificationController());
    Get.lazyPut(()=>NotificationProvider());
  }

}