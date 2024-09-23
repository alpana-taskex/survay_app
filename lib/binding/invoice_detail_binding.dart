import 'package:get/get.dart';

import '../modules/invoice/invoice_controller.dart';

class InvoiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>  InvoiceController());
  }
}
