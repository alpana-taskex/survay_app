import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/modules/job/job_controller.dart';
import 'package:crew_app/widgets/job_widgets/button/media_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MediaContent extends StatelessWidget {
  const MediaContent({
    super.key,
    required this.controller,
  });

  final JobController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.images.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vPad92,
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Assets.svgs.iconEmpty.svg(),
          ),
          vPad16,
          Text(
            "It looks like no photos have been added to this job. Tap ‘+’ icon to upload your media.",
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.bodySmall,
          ),
          spacer,
          MediaButton(controller: controller),
        ],
      );
    } else {
      return const Column(
        children: [
/*          Obx(() {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.images.length,
              itemBuilder: (context, index) {
                // Access the ImageItem instead of just a File
                final imageItem = controller.images[index];
                final image = imageItem.imageFile;
                final pickedTime = imageItem.pickedTime;

                // Convert to 12-hour format and determine AM/PM
                int hour = pickedTime.hour;
                String period = hour >= 12 ? 'PM' : 'AM';
                hour = hour % 12 == 0
                    ? 12
                    : hour % 12; // Convert hour to 12-hour format

                // Format the time string
                String formattedTime =
                    "$hour:${pickedTime.minute.toString().padLeft(2, '0')} $period";

                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    path.basename(image.path),
                    overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodySmall!.copyWith(
                      color: ColorName.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Today at $formattedTime\n${(image.lengthSync() / 1024).toStringAsFixed(1)}KB',
                    style: Get.theme.textTheme.bodySmall,
                  ),
                  trailing: Assets.svgs.iconDownload.svg(height: 16),
                );
              },
            );
          })*/
        // MediaButton(controller: controller),
        ],
      );
    }
  }
}


