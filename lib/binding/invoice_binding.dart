import 'package:crew_app/modules/invoice/invoice_controller.dart';
import 'package:get/get.dart';

class InvoiceBinding implements  Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => InvoiceController());
  }
}