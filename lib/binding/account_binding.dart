import 'package:crew_app/modules/account/account_controller.dart';
import 'package:crew_app/providers/account_provider.dart';
import 'package:get/get.dart';


class AccountBinding implements  Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => AccountProvider());
  }
}