import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/custom_input_widgets.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/login/login_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: screenHeight * 0.12,
        ),
        child: Form(
          key: controller.formKey,
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 72,
                    ),
                    hPad12,
                    Text(
                      "mover",
                      style: Get.textTheme.displayMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ) ??
                          const TextStyle(),
                    ),
                    Text(
                      "mate",
                      style: Get.textTheme.displayMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ) ??
                          const TextStyle(),
                    ),
                  ],
                ),
                vPad48,
                TextInputField(
                  height: 48,
                  textInputType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  label: 'Enter Device Name',
                  onChanged: (String s) {
                    controller.Name = s;
                  },
                  // validator: emailValidatorNotEmpty,
                ),
                vPad24,
                Obx(
                  () => TextInputField(
                    height: 48,
                    label: 'Password',
                    autofillHints: const [AutofillHints.password],
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !controller.showPassword.value,
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
                      ),
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        color: ColorName.gray5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                vPad32,
                Obx(
                  () => InputButton(
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                    label: 'Sign In',
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

