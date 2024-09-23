import 'package:crew_app/providers/job_provider.dart';
import 'package:get/get.dart';
import '../modules/job/job_controller.dart';

class JobBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobController());
    Get.lazyPut(() => JobProvider());
  }
}
