import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/modules/job/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryContent extends StatelessWidget {
  const InventoryContent({
    super.key,
    required this.controller,
  });

  final JobController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.inventoryItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vPad32,
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Assets.svgs.iconEmpty.svg()),
            vPad16,
            Text(
              textAlign: TextAlign.center,
              "Your list is currently empty. Items will appear here once added.",
              style: Get.theme.textTheme.bodySmall,
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          vPad16
/*          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.inventoryItems.length,
              itemBuilder: (context, index) {
                final item = controller.inventoryItems[index];
                return Card(
                  elevation: 0,
                  color: ColorName.white,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => controller.toggleItemExpansion(item),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            item.name,
                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                              color: ColorName.black,
                            ),
                          ),
                          trailing: Obx(() {
                            return Icon(
                              item.isExpanded.value == true
                                  ? CupertinoIcons.chevron_up
                                  : CupertinoIcons.chevron_down,
                              color: ColorName.blue1,
                              size: 17,
                            );
                          }),
                          minTileHeight: 8,
                        ),
                        Obx(
                              () {
                            return item.isExpanded.value
                                ? SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: item.description.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    minVerticalPadding: 2,
                                    contentPadding:
                                    const EdgeInsets.all(0),
                                    minTileHeight: 2,
                                    title: Text(
                                      item.description[index],
                                      style:
                                      Get.theme.textTheme.bodyMedium,
                                    ),
                                    trailing: Text(
                                      "${item.length[index]} m³",
                                      style:
                                      Get.theme.textTheme.bodySmall,
                                    ),
                                  );
                                },
                              ),
                            )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )*/,
        ],
      );
    }
  }
}