import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownField extends StatelessWidget {
  const DropDownField({
    super.key,
    required this.label1,
    required this.label,
    required this.hintText,
    required this.items,
    required this.selectedValue,
  });

  final String label1;
  final String label;
  final String hintText;
  final List<String> items;
  final RxString selectedValue;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: Get.theme.textTheme.titleSmall,
              ),
              hPad4,
              Text(
                label1,
                style: const TextStyle(color: ColorName.red3),
              ),
            ],
          ),
          vPad8,
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorName.gray11.withOpacity(0.5),
            ),
            child: DropdownButton<String>(
              icon: const Icon(
                CupertinoIcons.chevron_down,
                color: ColorName.blue4,
                size: 17,
              ),
              isExpanded: true,
              underline: Container(),
              focusColor: ColorName.white,
              borderRadius: BorderRadius.circular(5),
              hint: Text(
                hintText,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: ColorName.gray8,
                ),
              ),
              value: items.contains(selectedValue.value) &&
                  selectedValue.value.isNotEmpty
                  ? selectedValue.value
                  : null,
              items: items.toSet().map((item) {
                // Ensure unique items
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                selectedValue.value = value ?? '';
              },
            ),
          ),
        ],
      ),
    );
  }
}
