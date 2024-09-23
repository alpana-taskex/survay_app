import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryText extends StatelessWidget {
  const InventoryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Text for Inventory tab
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: const BoxDecoration(
        color: ColorName.white,
        border: Border(top: BorderSide(color: ColorName.gray10)),
      ),
      child: Center(
        child: Text(
          'Inventory details will be displayed here.',
          style:
          Get.theme.textTheme.bodyMedium!.copyWith(color: ColorName.black),
        ),
      ),
    );
  }
}