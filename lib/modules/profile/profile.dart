import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/custom_drop_down.dart';
import 'package:crew_app/components/custom_input_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/frequent_widgets.dart';
import '../../gen/colors.gen.dart';
import 'profile_controller.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Obx(() {
        if (controller.isLoadingMain.value) {
          return Padding(padding: const EdgeInsets.only(top: 16), child: customLoadingIndicator(content: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                    'Name', controller.nameController, enabled: false, (value) => controller.updateUser(name: value)),
                _buildTextField(
                    'Email Address',
                    enabled: false,
                    controller.emailController,
                        (value) => controller.updateUser(email: value)),
                _buildTextField(
                    'Phone Number', controller.phoneController, (value) => controller.updateUser(phone: value)),
                _buildTextField(
                    'ABN Number', controller.abnController, (value) => controller.updateUser(abnNumber: value), obscureText: true),
                _buildTextField(
                    'TFN Number', controller.tfnController, (value) => controller.updateUser(tfnNumber: value),
                    obscureText: true),
                _buildDropdown('GST Registered', controller.user.value.isGstRegistered ? 'Yes' : 'No', ['Yes', 'No'],
                    onChanged: (value) => controller.updateUser(isGstRegistered: value == 'Yes')),
                _buildDropdown('Department',  enabled: false,controller.user.value.department, ['DRIVER', 'OFFSIDER', 'MANAGER', 'HR']),
                _buildDropdown('Employment Type', enabled: false,controller.user.value.employmentType,
                    ['FULL_TIME', 'PART_TIME', 'CONTRACT']),
              ],
            ),
          )));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  'Name', controller.nameController, enabled: false, (value) => controller.updateUser(name: value)),
              _buildTextField(
                  'Email Address',
                  enabled: false,
                  controller.emailController,
                  (value) => controller.updateUser(email: value)),
              _buildTextField(
                  'Phone Number', controller.phoneController, (value) => controller.updateUser(phone: value)),
              _buildTextField(
                  'ABN Number', controller.abnController, (value) => controller.updateUser(abnNumber: value)),
              _buildTextField(
                  'TFN Number', controller.tfnController, (value) => controller.updateUser(tfnNumber: value)),
              _buildDropdown('GST Registered', controller.user.value.isGstRegistered ? 'Yes' : 'No', ['Yes', 'No'],
                 onChanged: (value) => controller.updateUser(isGstRegistered: value == 'Yes')),
              _buildDropdown('Department',  enabled: false,controller.user.value.department, ['DRIVER', 'OFFSIDER', 'MANAGER', 'HR']),
              _buildDropdown('Employment Type', enabled: false,controller.user.value.employmentType,
                  ['FULL_TIME', 'PART_TIME', 'CONTRACT']),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 20, bottom: 20),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorName.gray10),
          ),
        ),
        child: Obx(()=>InputButton(
          height: 48,
          isLoading: controller.isLoading.value,
          onPressed: controller.saveForm,
          label: 'Save',
        )),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged,
      {bool obscureText = false, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.bodySmall!.copyWith(
            color: ColorName.black,
          ),
        ),
        vPad6,
        TextInputField(
          height: 44,
          enabled: enabled,
          prefix: label == 'Phone Number'?Text('+61 ', style: Get.textTheme.bodyMedium!.copyWith(
              color: ColorName.blue3),):null,
          obscureText: obscureText,
          /*textStyle: Get.textTheme.bodyMedium!.copyWith(
            color: ColorName.gray2,
            fontWeight: FontWeight.normal,
          ),*/
          onChanged: onChanged,
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          controller: controller,
        ),
        vPad14,
      ],
    );
  }

  Widget _buildDropdown<T>(String label, T value, List<T> items, {Function(T?)? onChanged, bool enabled=true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.bodySmall!.copyWith(
            color: ColorName.black,
          ),
        ),
        vPad6,
        CustomDropdown<T>(
          value: value,
          enabled: enabled,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString(), style: Get.textTheme.bodyMedium!.copyWith( color: ColorName.gray2),),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        vPad14,
      ],
    );
  }
}
