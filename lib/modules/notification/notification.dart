import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/notification_model.dart';
import 'package:crew_app/modules/notification/notification_controller.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

class Notification extends GetView<NotificationController> {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Notifications'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: customLoadingIndicator(),
          );
        }
        if (controller.notifications.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.svgs.iconEmpty.svg(),
              SizedBox(
                width: Get.width,
                height: 14,
              ),
              Text(
                "No Notifications Yet",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorName.black,
                ),
              ),
              vPad6,
              Text(
                "You're all caught up! Check back later for updates.",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorName.gray3,
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemBuilder: (context, i) {
            return buildNotificationCard(controller.notifications[i]);
          },
          // separatorBuilder: (context, i){
          //   if(i==0 || i == controller.notifications.length) return vPad16;
          //   return Container();
          // },
          itemCount: controller.notifications.length,
        );
      }),
    );
  }

  Widget buildNotificationCard(NotificationModel notification) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: ColorName.white,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorName.blue12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: getNotificationIcon(notification.title ?? '')),
          hPad12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      notification.title ?? 'No Title',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorName.black,
                      ),
                    ),
                    Text(
                      '${timeago.format(DateTime.parse(notification.receivedAt??'', ), locale: 'en_short')} ago',
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 0.20,
                        color: ColorName.gray7,
                      ),
                    ),
                  ],
                ),
                vPad2,
                Text(
                  notification.content ?? 'No Content',
                  style: Get.textTheme.labelSmall!.copyWith(
                    color: ColorName.gray6,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getNotificationIcon(String title) {
    final icon = Assets.svgs.iconJob.svg();
    if (title.contains('Removed')) return Assets.svgs.iconRemove.svg();
    if (title.contains('Message')) return Assets.svgs.iconMessage.svg();
    if (title.contains('Details')) return Assets.svgs.iconDetails.svg();
    return icon;
  }
}
