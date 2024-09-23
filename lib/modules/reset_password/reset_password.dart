import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/custom_input_widgets.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/reset_password/reset_password_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/widgets/dialog.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends GetView<ResetPasswordController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(onBack: () => Get.offAllNamed(Routes.login)),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reset Password",
                      style: Get.textTheme.headlineMedium!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  vPad2,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Please type something you’ll remember",
                      style: Get.textTheme.bodySmall!
                          .copyWith(color: ColorName.gray8),
                    ),
                  ),
                  vPad32,
                  TextInputField(
                    label: 'Old Password',
                    obscureText: !controller.showOldPassword.value,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      icon: controller.showOldPassword.value
                          ? const Icon(
                              Icons.visibility_off,
                              color: ColorName.blue3,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        controller.showOldPassword.value =
                            !controller.showOldPassword.value;
                      },
                    ),
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return 'Enter old password';
                      }
                      return null;
                    },
                    onChanged: (s) {
                      controller.password = s;
                    },
                  ),
                  vPad16,
                  TextInputField(
                    label: 'New Password',
                    obscureText: !controller.showNewPassword.value,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      icon: controller.showNewPassword.value
                          ? const Icon(
                              Icons.visibility_off,
                              color: ColorName.blue3,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        controller.showNewPassword.value =
                            !controller.showNewPassword.value;
                      },
                    ),
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return 'Enter new password';
                      }
                      return null;
                    },
                    onChanged: (s) {
                      controller.password = s;
                    },
                  ),
                  vPad16,
                  TextInputField(
                    label: 'Repeat New Password',
                    obscureText: true,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: Colors.grey,
                    ),
                    validator: (String? s) {
                      if (controller.password.isEmpty &&
                          s != null &&
                          s.isEmpty) {
                        return null;
                      }
                      if (s == null || s.isEmpty) {
                        return 'Enter same password again';
                      }
                      if (s != controller.password) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  vPad28,
                  InputButton(
                    isLoading: controller.isLoading.value,
                    onPressed: controller.resetPassword,
                    label: 'Reset Password',
                  ),
                  vPad26,
                  if (controller.email != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remembered your password? ',
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: ColorName.gray1,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => Get.toNamed(Routes.login),
                          child: Text(
                            '  Sign In  ',
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: ColorName.blue1,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(flex: 3),
                ],
              )),
        ),
      ),
    );
  }
}

void showPasswordChangedDialog() {
  CustomDialog(
      barrierDismissible: false,
      onSubmitted: () {
        Get.offAllNamed(Routes.login);
      },
      actionText: 'Back To Login',
      content: Column(
        children: [
          vPad24,
          Assets.svgs.iconSuccess.svg(height: 64),
          vPad16,
          Text(
            'Password Changed',
            style:
                Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          vPad4,
          Text(
            'Your password has been changed successfully!',
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray8),
          ),
          vPad8
        ],
      )).show();
}
