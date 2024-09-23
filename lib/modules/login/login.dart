import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/custom_input_widgets.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/login/login_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: controller.formKey,
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Assets.svgs.logo.svg(height: 72),
                vPad16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      "mover",
                      style: Get.textTheme.displaySmall!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "mate",
                      style: Get.textTheme.displaySmall!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                vPad48,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back!",
                    style: Get.textTheme.displaySmall!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w700),
                  ),
                ),
                vPad4,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please enter all your details",
                    style: Get.textTheme.bodySmall!
                        .copyWith(color: ColorName.gray8),
                  ),
                ),
                vPad36,
                TextInputField(
                  height: 48,
                  textInputType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  prefixIcon: const Icon(
                    Icons.alternate_email_rounded,
                    color: Colors.grey,
                  ),
                  label: 'Username',
                  onChanged: (String s) {
                    controller.email = s;
                  },
                  // validator: emailValidatorNotEmpty,
                ),
                vPad16,
                Obx(
                  () => TextInputField(
                    height: 48,
                    label: 'Password',
                    autofillHints: const [AutofillHints.password],
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !controller.showPassword.value,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      icon: controller.showPassword.value
                          ? const Icon(
                              Icons.visibility_off,
                              color: ColorName.blue3,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        controller.showPassword.value =
                            !controller.showPassword.value;
                      },
                    ),
                    onChanged: (String s) {
                      controller.password = s;
                    },
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.forgot),
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ), // Removes the splash effect
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          color: ColorName.gray5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                vPad32,
                Obx(
                  () => InputButton(
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                    label: 'Get Started',
                  ),
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

/*InkWell(
                      child: Lottie.asset(
                        height: 24,
                        'assets/lotties/password_eye.json',
                        controller: controller.controller,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          controller.controller.forward();
                        },
                      ),
                      onTap: () {
                        controller.showPassword.value = !controller.showPassword.value;
                        controller.controller.reverse();

                      },
                    ),*/
}
