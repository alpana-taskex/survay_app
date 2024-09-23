import 'package:crew_app/components/frequent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../gen/colors.gen.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: Get.textTheme.bodyMedium!.copyWith(
                color: ColorName.black,
              ),
            ),
            spacer,
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: value ? ColorName.blue3 : ColorName.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: value ? ColorName.blue3 : ColorName.gray10),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorName.gray12,
                      blurRadius: 4,
                      spreadRadius: 4,
                    )
                  ]),
              child: value
                  ? const Icon(Icons.check, size: 14, color: ColorName.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
