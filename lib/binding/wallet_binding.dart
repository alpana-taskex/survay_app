import 'package:crew_app/modules/wallet/wallet_controller.dart';
import 'package:crew_app/providers/wallet_provider.dart';
import 'package:get/get.dart';


class WalletBinding implements  Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => WalletProvider());
  }
}