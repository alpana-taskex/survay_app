import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          titleWidget: Text(
            "ABOUT US",
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
        child: Column(
          children: [
            _buildTwoSection('Our Mission',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
            vPad12,
            _buildTwoSection('Our Vision',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
          ],
        ),
      ),
    );
  }

  Widget _buildTwoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorName.black,
            height: 2.2,
          ),
        ),
        vPad8,
        Text(
          content,
          style: Get.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorName.black,
            height: 2.0,
          ),
        )
      ],
    );
  }
}
