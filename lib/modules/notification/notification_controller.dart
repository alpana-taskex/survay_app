import 'package:crew_app/models/notification_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/notification_provider.dart';
import 'package:get/get.dart';

class NotificationController extends BaseController {

  final provider = Get.find<NotificationProvider>();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();

  }

  void fetchNotifications() {
    showLoader();
    provider.notifications().then((List<NotificationModel> data) {
      notifications.value = data;
      notifications.refresh();
    }).whenComplete(hideLoader);
  }

}