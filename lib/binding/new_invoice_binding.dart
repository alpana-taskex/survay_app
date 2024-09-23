import 'package:crew_app/modules/new_invoice/new_invoice_controller.dart';
import 'package:get/get.dart';

class NewInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewInvoiceController());
  }
}
