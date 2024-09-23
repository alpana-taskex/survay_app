import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/models/profile_model.dart';
import 'package:crew_app/modules/account/account.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/account_provider.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AccountController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final Rxn<ProfileModel> user = Rxn<ProfileModel>();

  RxBool showOldPassword = false.obs;
  RxBool showNewPassword = false.obs;
  RxBool showRepeatPassword = false.obs;
  String password = '';
  String oldPassword = '';
  final RxBool isAvatarUpdating = false.obs;
  final RxnString localAvatarPath = RxnString();
  final AccountProvider accountProvider = Get.find<AccountProvider>();
  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final fetchedUser = await accountProvider.getProfile();
    if (fetchedUser != null) {
      user.value = fetchedUser;
      localAvatarPath.value = null;
    }
  }

  Future<void> uploadAvatar({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    Get.back();

    if (file != null) {
      try {
        isAvatarUpdating.value = true;
        localAvatarPath.value = file.path;

        final bool uploadSuccess = await accountProvider.uploadAvatar(file);
        if (uploadSuccess) {
          await fetchUser();
          // Get.snackbar('Success', 'Avatar updated successfully');
        } else {
          localAvatarPath.value = null; // Clear local path if upload fails
          // Get.snackbar('Error', 'Failed to update avatar');
        }
      } catch (e) {
        logger.e('Error uploading avatar: $e');
        localAvatarPath.value = null;
        // Get.snackbar('Error', 'An error occurred while uploading avatar');
      } finally {
        isAvatarUpdating.value = false;
      }
    }
  }

  void resetPassword() {
    Get.toNamed(Routes.resetPasswordWithOld, arguments: {});
  }

  void showFAQs() {
    Get.toNamed(Routes.faq);
  }

  void showProfile() {
    Get.toNamed(Routes.profile);
  }

  void showHelpAndSupport() {
    Get.toNamed(Routes.help);
  }

  void showTermOfUse() => openWebView('https://movermate.com.au/terms-of-service', 'Terms & Condition');

  void showAboutUs() => Get.toNamed(Routes.aboutUs);

  void showLanguage() => Get.toNamed(Routes.language);

  void showPrivacy() => openWebView('https://movermate.com.au/privacy-policy', 'Privacy Policy');

  void signOut() {
    final box = GetStorage();
    box.remove('user');
    box.remove('token');
    Constants.user = null;
    Constants.token = null;
    Get.offAllNamed(Routes.login);
    Constants.tabSelected = 'home';
  }

  void changePassword() {
    if(!formKey.currentState!.validate()) return;
    final body = {"password": password, "oldpassword": oldPassword};
    isLoading.value = true;
    accountProvider.resetPassword(body).then((successful) {
      if (successful) {
        showSnackBar(message: 'Password Changed Successfully.');
        formKey.currentState!.reset();
      }
    }).whenComplete(() => isLoading.value = false);
  }

  void openWebView(String url, String title) {
    Navigator.push(
        Get.context!,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => WebViewExample(
            url: url,
            title: title,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start from right side
            const end = Offset(0.0, 0.0); // End at center
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ));
  }
}
