import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/language/language_controller.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class Language extends GetView<LanguageController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          titleWidget: Text(
            "LANGUAGES",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 27,
            mainAxisSpacing: 18,
            childAspectRatio: 150 / 120,
          ),
          itemCount: controller.languages.length,
          itemBuilder: (context, index) {
            final language = controller.languages[index];
            return _buildLanguageCard(language['name']!, language['sample']!);
          },
        ),
      ),
    );
  }

  Widget _buildLanguageCard(String language, String letterSample) {
    return Obx(() => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => controller.setLanguage(language),
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 0, 0, 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.selectedLanguage.value == language
                    ? ColorName.blue3
                    : ColorName.gray11,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  letterSample,
                  style: Get.textTheme.displayLarge!.copyWith(
                    color: controller.selectedLanguage.value == language
                        ? ColorName.blue3
                        : ColorName.black,
                    fontWeight: controller.selectedLanguage.value == language
                        ? FontWeight.w500
                        : FontWeight.normal,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  language,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: controller.selectedLanguage.value == language
                        ? ColorName.blue3
                        : ColorName.black,
                    fontWeight: FontWeight.w500,
                    height: 2.2,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
