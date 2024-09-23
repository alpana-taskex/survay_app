import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/modules/forgot/forgot_controller.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button_input.dart';
import '../../components/custom_input_widgets.dart';
import '../../gen/colors.gen.dart';
import '../../routes/app_pages.dart';

class ForgotScreen extends GetView<ForgotController> {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(flex: 1,),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Forgot Password",
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            vPad4,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter your username and we’ll send you confirmation code to reset your password",
                style: Get.textTheme.bodySmall!.copyWith(color: ColorName.gray8),
              ),
            ),
            vPad32,
            Form(
              key: controller.formKey,
              child: TextInputField(
                focusNode: controller.focusNode,
                label: 'username',
                onChanged: (String s) => controller.email = s,
                // validator: emailValidatorNotEmpty,
              ),
            ),
            const SizedBox(height: 92,),
            Obx(
              () => InputButton(
                onPressed: controller.sendVerificationCode,
                isLoading: controller.isLoading.value,
                label: 'Send Code',
              ),
            ),
            const Spacer(flex: 3,),

          ],
        ),
      ),
    );
  }
}

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Screen'),
      ),
      body: ListView(
        children: [
          ...AppPages.routes.map((page) {
            return ElevatedButton(
                onPressed: () {
                  Get.toNamed(page.name);
                },
                child: Text(page.name));
          })
        ],
      ),
    );
  }
}
