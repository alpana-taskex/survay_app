import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/schedule_item_model.dart';
import 'package:crew_app/modules/calendar/calendar_controller.dart';
import 'package:crew_app/widgets/bottombar.dart';
import 'package:crew_app/widgets/custom_calendar.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Calendar extends GetView<CalendarController> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 170),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Calendar",
                    style: Get.textTheme.titleLarge!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              vPad24,
              Obx(
                () => CustomSlidingSegmentedControl<int>(
                  initialValue: controller.selectedTabIndex.value,
                  children: {
                    0: Text(
                      'Schedule',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: controller.selectedTabIndex.value == 0
                            ? ColorName.blue3
                            : ColorName.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    1: Text(
                      'Availability',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: controller.selectedTabIndex.value == 1
                            ? ColorName.blue3
                            : ColorName.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  },
                  isStretch: true,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorName.blue3.withOpacity(.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  innerPadding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  thumbDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  onValueChanged: controller.onValueChanged,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Obx(() => CustomCalendarWidget(
                  onDateSelected: (val) {
                    controller.selectedDate.value = val;
                  },
                  showHighlight: controller.selectedTabIndex.value == 0,
                )),
            vPad22,
            Obx(
              () => Expanded(
                child: controller.selectedTabIndex.value == 1
                    ? _buildAvailabilityList()
                    : _buildScheduleList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityList() {
    return ListView(
      children: [
        _buildAvailabilityItem(
          date: 'Thursday 27 July',
          description: 'Availability already released',
          isEditable: false,
        ),
        _buildAvailabilityItem(
          date: 'Friday 28 July',
          description: 'Add Availability',
          isEditable: true,
        ),
        _buildAvailabilityItem(
          date: 'Saturday 29 July',
          description: 'Add Availability',
          isEditable: true,
        ),
        _buildAvailabilityItem(
          date: 'Sunday 30 July',
          description: 'Available All Day\nRepeats Every Sunday',
          isEditable: true,
          isRepeating: true,
        ),
        _buildAvailabilityItem(
          date: 'Monday 1 August',
          description: 'Add Availability',
          isEditable: true,
        ),
      ],
    );
  }

  Widget _buildScheduleList() {
    return Obx(() {
      final selectedDate = controller.selectedDate.value;
      final filteredItems = controller.scheduleItems
          .where((item) =>
              item.date.year == selectedDate.year &&
              item.date.month == selectedDate.month &&
              item.date.day == selectedDate.day)
          .toList();

      return Column(
        children: [
          Row(
            children: [
              Text(
                DateFormat('EEEE ').format(selectedDate),
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorName.black,
                ),
              ),
              Text(
                DateFormat('d MMMM').format(selectedDate),
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorName.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svgs.iconEmpty.svg(),
                        vPad12,
                        Text(
                          "You don't have any jobs scheduled at the moment. Check back later for updates.",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorName.gray3,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, i) => vPad12,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, i) {
                      var item = filteredItems[i];
                      return _buildScheduleItem(item);
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildScheduleItem(ScheduleItemModel item) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: ColorName.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.timeRange,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorName.black,
            ),
          ),
          vPad6,
          _buildRowWidget('Job ID', item.jobId),
          vPad6,
          _buildRowWidget('Custom Name', item.customerName),
          vPad6,
          Text(
            item.location,
            style: Get.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorName.gray3,
                height: 1.6),
          ),
          vPad4,
          Row(
            children: [
              Text(
                item.items,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorName.gray3,
                  height: 1.6,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRowWidget(String firstTitle, String secondTitle) {
    return Row(
      children: [
        Text(
          '$firstTitle ',
          style: Get.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500, color: ColorName.gray3, height: 1.6),
        ),
        Text(
          secondTitle,
          style: Get.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600, color: ColorName.black, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildAvailabilityItem({
    required String date,
    required String description,
    bool isEditable = false,
    bool isRepeating = false,
  }) {
    return ListTile(
      title: Text(
        date,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        description,
        style: Get.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.normal,
          color: ColorName.gray1.withOpacity(.3),
        ),
      ),
      trailing: isEditable
          ? isRepeating
              ? Assets.svgs.iconEdit.svg()
              : Assets.svgs.iconAdd.svg()
          : null,
    );
  }
}
