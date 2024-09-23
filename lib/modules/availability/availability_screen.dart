import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/availability/availabilty_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_clndr.dart';

class AvailabilityScreen extends GetView<AvailabilityController> {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing theme data
    final theme = Theme.of(context).copyWith();
    final textColor = theme.textTheme.bodyLarge!.color;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Assets.svgs.iconBackArrow.svg(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Availability",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorName.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shift",
                      style: Get.theme.textTheme.bodySmall!
                          .copyWith(color: ColorName.black)),
                  vPad8,
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorName.gray11.withOpacity(0.4),
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        underline: Container(),
                        focusColor: ColorName.white,
                        borderRadius: BorderRadius.circular(5),
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: ColorName.blue4,
                          size: 17,
                        ),
                        isExpanded: true,
                        value: controller.selectedShift.value.isEmpty
                            ? null
                            : controller.selectedShift.value,
                        hint: Text(
                          "Select",
                          style: Get.theme.textTheme.bodyMedium,
                        ),
                        items: ["Morning", "Afternoon/Evening", "Full-day"]
                            .map((shift) {
                          return DropdownMenuItem<String>(
                            value: shift,
                            child: Text(shift),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedShift.value = value!;
                        },
                      ),
                    ),
                  ),
                  vPad24,
                  Text("Make this shift recur:",
                      style: Get.theme.textTheme.bodyMedium!
                          .copyWith(color: ColorName.black)),
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorName.blue4,
                              value: false,
                              groupValue: controller.isWeekly.value,
                              onChanged: (value) {
                                controller.toggleRecurrence(value!);
                              },
                            ),
                            Text(
                              "Never",
                              style: Get.theme.textTheme.bodyMedium!
                                  .copyWith(color: ColorName.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: ColorName.blue4,
                              value: true,
                              groupValue: controller.isWeekly.value,
                              onChanged: (value) {
                                controller.toggleRecurrence(value!);
                              },
                            ),
                            Text(
                              "Weekly",
                              style: Get.theme.textTheme.bodyMedium!
                                  .copyWith(color: ColorName.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => controller.isWeekly.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Day names row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(7, (index) {
                                  return SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        [
                                          "Sun",
                                          "Mon",
                                          "Tue",
                                          "Wed",
                                          "Thu",
                                          "Fri",
                                          "Sat"
                                        ][index],
                                        style: Get.theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              vPad8,
                              // Selectable day boxes row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(7, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.toggleWeekday(index);
                                    },
                                    child: Obx(
                                      () => Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: controller
                                                  .selectedWeekdays[index]
                                              ? ColorName.blue4 // Blue color
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: ColorName
                                                  .gray11), // Grey border
                                        ),
                                        child: Center(
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                              color: controller
                                                      .selectedWeekdays[index]
                                                  ? Colors.white
                                                  : Colors
                                                      .transparent, // Hidden text
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              vPad16,
                              Text("Recurrence Start Date",
                                  style: Get.theme.textTheme.bodyMedium!
                                      .copyWith(color: ColorName.black)),
                              vPad8,
                              GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: ColorName.blue4,
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
                                            onSurface: ColorName
                                                .black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: ColorName
                                                  .blue4, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    controller.setStartDate(pickedDate);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorName.gray11.withOpacity(0.4),
                                  ),
                                  child: Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.startDate.value != null
                                              ? controller.startDate.value!
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0]
                                              : 'Select',
                                          style: const TextStyle(
                                            color: ColorName.gray9,
                                          ),
                                        ),
                                        Assets.svgs.iconCalendar.svg(
                                          colorFilter: const ColorFilter.mode(
                                            ColorName.blue4,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              vPad16,
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: controller.endDate.value != null,
                                      onChanged: (checked) {
                                        if (checked == true) {
                                          controller.setEndDate(DateTime
                                              .now()); // Set default date when checked
                                        } else {
                                          controller.setEndDate(null);
                                          // Clear the date when unchecked
                                        }
                                      },
                                      activeColor: ColorName.blue4,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      checkColor: ColorName.white,
                                    ),
                                  ),
                                  Text("Set Recurrence End Date",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: textColor,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Obx(
                                () => controller.endDate.value != null
                                    ? GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2030),
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary: ColorName.blue4,
                                                    // header background color
                                                    onPrimary: Colors.white,
                                                    // header text color
                                                    onSurface: ColorName
                                                        .black, // body text color
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: ColorName
                                                          .blue4, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (pickedDate != null) {
                                            controller.setEndDate(pickedDate);
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ColorName.gray11
                                                .withOpacity(0.4),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.endDate.value != null
                                                    ? controller.endDate.value!
                                                        .toLocal()
                                                        .toString()
                                                        .split(' ')[0]
                                                    : 'Select',
                                                style: const TextStyle(
                                                  color: ColorName.gray9,
                                                ),
                                              ),
                                              Assets.svgs.iconCalendar.svg(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  ColorName.blue4,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          )
                        : CustomCalendar(
                            selectedDates: controller.selectedDates,
                            onDateSelected: (dates) {
                              // Adjust to handle a list of dates if you want multi-date selection
                              controller.selectedDates();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorName.gray8),
          ),
        ),
        padding:
            const EdgeInsets.only(top: 22, right: 20, left: 20, bottom: 24),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            controller.confirmAvailability();
          },
          style: ElevatedButton.styleFrom(
            maximumSize: const Size(327, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: ColorName.blue4,
          ),
          child: Text(
            "Confirm Availability",
            style: Get.theme.textTheme.titleMedium!.copyWith(
              color: ColorName.white,
            ),
          ),
        ),
      ),
    );
  }
}
