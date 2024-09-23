import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/job/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignContent extends StatelessWidget {
  const SignContent({
    super.key,
    required this.controller,
  });

  final JobController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: controller.signItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              minTileHeight: 8,
              title: Text(
                controller.signItems[index],
                style: Get.theme.textTheme.titleSmall!.copyWith(
                  color: ColorName.blue1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: ColorName.blue4,
                size: 14,
              ),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}