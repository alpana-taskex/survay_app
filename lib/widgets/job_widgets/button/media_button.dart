import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/job/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaButton extends StatelessWidget {
  const MediaButton({
    super.key,
    required this.controller,
  });

  final JobController controller;

  @override
  Widget build(BuildContext context) {
    // Button for Media tab
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: const BoxDecoration(
        color: ColorName.white,
        border: Border(top: BorderSide(color: ColorName.gray10)),
      ),
      child: ElevatedButton(
        onPressed: () => controller.pickImage(ImageSource.gallery),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(327, 48),
          elevation: 0,overlayColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorName.blue4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: ColorName.white,
            ),
            hPad8,
            Text(
              'Add  Photo',
              style: Get.theme.textTheme.titleLarge!
                  .copyWith(color: ColorName.white),
            ),
          ],
        ),
      ),
    );
  }
}







