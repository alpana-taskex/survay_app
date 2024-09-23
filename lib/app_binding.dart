import 'package:crew_app/providers/base_provider.dart';
import 'package:get/get.dart';


class AppBinding implements Bindings {

  @override
  void dependencies() async {
    Get.lazyPut(() => BaseProvider());

  }
}
