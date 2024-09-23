// faq_screen.dart
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/faq/faq_controller.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class FAQ extends GetView<FaqController> {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          titleWidget: Text(
            "FREQUENTLY ASKED QUESTIONS",
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorName.blue1,
            ),
          ),
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(TablerIcons.x),
            ),
          ]),
      body: Obx(() => Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
              itemCount: controller.faqItems.length,
              itemBuilder: (context, index) {
                final item = controller.faqItems[index];
                return Obx(
                  () => ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      item.question,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: ColorName.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    initiallyExpanded: item.isExpanded.value,
                    onExpansionChanged: (expanded) {
                      controller.toggleExpansion(index);
                    },
                    shape: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorName.gray10)
                    ),
                    collapsedShape: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorName.gray10)
                    ),
                    trailing: item.isExpanded.value
                        ? Assets.svgs.iconDropup.svg()
                        : Assets.svgs.iconDropdown.svg(),
                    children: [
                      Text(
                        item.answer,
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: ColorName.black,
                          height: 2.0
                        ),
                      ),
                      vPad16
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
