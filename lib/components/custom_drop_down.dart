import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final bool enabled;

  const CustomDropdown({
    super.key,
    this.value,
    required this.items,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      value: value,
      items: items,
      onChanged: onChanged,

      underline: Container(),
      buttonStyleData: ButtonStyleData(
        height: 44,
        overlayColor: WidgetStateProperty.all(ColorName.blue11),
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color:ColorName.blue12,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Assets.svgs.iconDropdown.svg(),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        elevation: 3,
        offset: const Offset(0, -4),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all(6),
          thumbVisibility: WidgetStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      style: Get.textTheme.bodyMedium!.copyWith( color: ColorName.gray2),
    );
  }
}