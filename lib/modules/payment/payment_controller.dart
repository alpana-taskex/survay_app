import 'package:crew_app/models/payment_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class PaymentController extends BaseController {
  final payment = PaymentModel().obs;

  void updatePaymentMethod(String method) {
    payment.update((val) {
      val?.paymentMethod = method;
    });
  }

  void updateAmount(double value) {
    payment.update((val) {
      val?.amount = value;
    });
  }

  void updateField(String field, String value) {
    payment.update((val) {
      switch (field) {
        case 'cardNumber':
          val?.cardNumber = value;
          break;
        case 'cardholderName':
          val?.cardholderName = value;
          break;
        case 'expiry':
          val?.expiry = value;
          break;
        case 'cvv':
          val?.cvv = value;
          break;
        case 'emailAddress':
          val?.emailAddress = value;
          break;
        case 'accountName':
          val?.accountName = value;
          break;
        case 'accountNumber':
          val?.accountNumber = value;
          break;
        case 'bsbNumber':
          val?.bsbNumber = value;
          break;
      }
    });
  }

  Map<String, dynamic> toJson() => payment.value.toJson();

  void fromJson(Map<String, dynamic> json) {
    payment.value = PaymentModel.fromJson(json);
  }
}