import 'package:crew_app/modules/verification/verification_controller.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/validators.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class Verification extends GetView<VerificationController> {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                "Enter the 4-digit code",
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              vPad4,
              Text(
                "Please enter the verification code sent to your email valid for 5 minutes.",
                style: Get.textTheme.bodySmall!.copyWith(color: ColorName.gray8),
              ),
              vPad16,
              Pinput(
                controller: controller.pinPutController,
                validator: validatePin,
                focusNode: controller.pinFocusNode,
                focusedPinTheme: PinTheme(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffF4F5FA),
                    border: Border.all(
                      color: const Color(0xff0000ff), // Example color
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorName.blue3.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 4,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                  textStyle: Get.textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffF4F5FA),
                    border: Border.all(
                      color: ColorName.red2,
                      width: 1,
                    ),
                  ),
                  textStyle: Get.textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                defaultPinTheme: PinTheme(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffF4F5FA),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  textStyle: Get.textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 92,
              ),
              Obx(
                () => InputButton(
                  onPressed: controller.verifyCode,
                  label: 'Verify',
                  isLoading: controller.isLoading.value,
                ),
              ),
              vPad26,
              Obx(() => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.timeRemaining.value == 0
                        ? [
                            Text(
                              'Didn’t get any code yet?',
                              style: Get.textTheme.bodySmall!.copyWith(
                                color: ColorName.gray1,
                              ),
                            ),
                            Obx(
                              () => controller.isLoadingSecond.value
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      height: 16,
                                      width: 16,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: controller.reSendVerificationCode,
                                      child: Text(
                                        'Resend code',
                                        style: Get.textTheme.bodySmall!.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: ColorName.blue3,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            ),
                          ]
                        : [
                            Text(
                              'Resend OTP in ',
                              style: Get.textTheme.bodySmall!.copyWith(
                                color: ColorName.gray1,
                              ),
                            ),
                            Text(
                              '${controller.timeRemaining.value}',
                              style: Get.textTheme.bodySmall!.copyWith(
                                color: ColorName.blue3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ' seconds',
                              style: Get.textTheme.bodySmall!.copyWith(
                                color: ColorName.gray1,
                              ),
                            ),
                          ],
                  )),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
