import 'package:crew_app/modules/dashboard/dashboard_controller.dart';
import 'package:crew_app/providers/dashboard_provider.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() async {
    // Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => DashboardProvider());
  }
}
