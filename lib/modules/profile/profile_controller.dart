import 'package:crew_app/components/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crew_app/models/profile_model.dart';
import 'package:crew_app/providers/account_provider.dart';
import 'package:logger/logger.dart';

class ProfileController extends GetxController {
  final user = ProfileModel().obs;
  final isLoading = false.obs;
  final isLoadingMain = true.obs;
  final AccountProvider accountProvider = Get.find<AccountProvider>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController abnController;
  late TextEditingController tfnController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    abnController = TextEditingController();
    tfnController = TextEditingController();
    fetchUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    abnController.dispose();
    tfnController.dispose();
    super.onClose();
  }

  Future<void> fetchUserData() async {
    try {
      isLoadingMain.value = true;
      final fetchedUser = await accountProvider.getProfile();
      if (fetchedUser != null) {
        user.value = fetchedUser;
        updateTextControllers();
      }
    } catch (e) {
      Logger().e(e);
    } finally {
      isLoadingMain.value = false;
    }
  }

  void updateTextControllers() {
    nameController.text = user.value.name;
    emailController.text = user.value.email;
    phoneController.text = user.value.phone;
    abnController.text = user.value.abnNumber;
    tfnController.text = user.value.tfnNumber;
  }

  void updateUser({
    String? name,
    String? email,
    String? phone,
    String? abnNumber,
    String? tfnNumber,
    bool? isGstRegistered,
    String? department,
    String? employmentType,
  }) {
    user.update((val) {
      if (val != null) {
        val.name = name ?? val.name;
        val.email = email ?? val.email;
        val.phone = phone ?? val.phone;
        val.abnNumber = abnNumber ?? val.abnNumber;
        val.tfnNumber = tfnNumber ?? val.tfnNumber;
        val.isGstRegistered = isGstRegistered ?? val.isGstRegistered;
        val.department = department ?? val.department;
        val.employmentType = employmentType ?? val.employmentType;
      }
    });
  }

  Future<void> saveForm() async {
    isLoading.value = true;
    final profileData = {
      'phone': phoneController.text,
      'abnNumber': abnController.text,
      'tfnNumber': tfnController.text,
      'isGstRegistered': user.value.isGstRegistered.toString(),
    };

    accountProvider.updateProfile(profileData).then((success) {
      if (success) {
        showSnackBar(success: true, message: 'Profile updated successfully');
      }
    }).whenComplete(() => isLoading.value = false);
  }
}
