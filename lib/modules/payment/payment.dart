import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/payment/payment_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/utils/common_widget.dart';
import 'package:crew_app/widgets/custom_radio_button.dart';
import 'package:crew_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends GetView<PaymentController> {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Assets.svgs.iconBackArrow.svg(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Payment",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorName.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24).copyWith(bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PAYMENT METHOD',
                        style: Get.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: ColorName.gray7,
                          height: 1.6,
                        ),
                      ),
                      vPad14,
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRadioButton(
                              value: 'Credit Card',
                              groupValue: controller.payment.value.paymentMethod,
                              onChanged: (value) =>
                                  controller.updatePaymentMethod(value),
                              label: 'Credit Card',
                            ),
                            CustomRadioButton(
                              value: 'Cash',
                              groupValue: controller.payment.value.paymentMethod,
                              onChanged: (value) =>
                                  controller.updatePaymentMethod(value),
                              label: 'Cash',
                            ),
                            CustomRadioButton(
                              value: 'Bank Transfer',
                              groupValue: controller.payment.value.paymentMethod,
                              onChanged: (value) =>
                                  controller.updatePaymentMethod(value),
                              label: 'Bank Transfer',
                            ),
                          ],
                        ),
                      ),
                      vPad22,
                      Obx(
                        () => _buildPaymentMethodFields(),
                      ),
                    ],
                  ),
                ),
                spacer,
                CommonWidget.dividerWidget(
                  width: Get.width,
                  thickness: 2,
                  color: ColorName.gray10,
                ),
                vPad22,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 24),
                    child: InputButton(
                      onPressed: () => Get.toNamed(Routes.payment),
                      label: 'Done',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodFields() {
    switch (controller.payment.value.paymentMethod) {
      case 'Credit Card':
        return _buildCreditCardFields();
      case 'Cash':
        return _buildCashFields();
      case 'Bank Transfer':
        return _buildBankTransferFields();
      default:
        return Container();
    }
  }

  Widget _buildCreditCardFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText('Amount'),
        CustomTextField(
          hintText: '\$ ${controller.payment.value.amount}',
          onChanged: (val) =>
              controller.updateAmount(double.tryParse(val) ?? 0),
        ),
        vPad14,
        _buildTitleText('Credit Card Number'),
        CustomTextField(
          hintText: 'xxxx xxxx xxxx xxxx',
          onChanged: (val) => controller.updateField('cardNumber', val),
        ),
        vPad14,
        _buildTitleText('Cardholder Name'),
        CustomTextField(
          hintText: 'Enter Name',
          onChanged: (val) => controller.updateField('cardholderName', val),
        ),
        vPad14,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleText('Expiry'),
                  vPad6,
                  CustomTextField(
                    hintText: 'Select',
                    onChanged: (val) => controller.updateField('expiry', val),
                  ),
                ],
              ),
            ),
            hPad11,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleText('CVV'),
                  vPad6,
                  CustomTextField(
                    hintText: 'xxx',
                    onChanged: (val) => controller.updateField('cvv', val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCashFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText('Enter Amount'),
        CustomTextField(
          hintText: '\$ 0.00',
          onChanged: (val) =>
              controller.updateAmount(double.tryParse(val) ?? 0),
        ),
      ],
    );
  }

  Widget _buildBankTransferFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText('Email Address'),
        CustomTextField(
          hintText: 'Enter Email Address',
          onChanged: (val) => controller.updateField('emailAddress', val),
        ),
        vPad12,
        _buildTitleText('Enter Amount'),
        CustomTextField(
          hintText: '\$ 0.00',
          onChanged: (val) =>
              controller.updateAmount(double.tryParse(val) ?? 0),
        ),
        vPad12,
        _buildTitleText('Account Name'),
        CustomTextField(
          hintText: 'ABC Movers',
          onChanged: (val) => controller.updateField('accountName', val),
        ),
        vPad12,
        _buildTitleText('Account Number'),
        CustomTextField(
          hintText: 'xxxxxx',
          onChanged: (val) => controller.updateField('accountNumber', val),
        ),
        vPad12,
        _buildTitleText('BSB Number'),
        CustomTextField(
          hintText: 'xxxxxx',
          onChanged: (val) => controller.updateField('bsbNumber', val),
        ),
        vPad12,
        _buildTitleText('Upload Logo'),
        InkWell(
          onTap: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            width: Get.width,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorName.gray11,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.svgs.iconUpload.svg(),
                vPad12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose file ',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: ColorName.blue3,
                      ),
                    ),
                    Text(
                      'to upload',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: ColorName.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleText(String firstText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: Get.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.normal,
                color: ColorName.black,
              ),
            ),
            TextSpan(
              text: '＊',
              style: Get.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.normal,
                color: ColorName.red1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
