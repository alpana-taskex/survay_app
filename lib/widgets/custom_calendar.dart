import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

typedef DateSelectedCallback = void Function(DateTime selectedDate);

class CustomCalendarWidget extends StatefulWidget {
  final DateSelectedCallback onDateSelected;
  final bool showHighlight;

  const CustomCalendarWidget({
    super.key,
    required this.onDateSelected,
    this.showHighlight = true,
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  late PageController _pageController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    selectedDate = DateTime.now();
    widget.onDateSelected(selectedDate!);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onDateTap(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  List<DateTime> _getDaysInWeek(DateTime week) {
    return List.generate(
        7,
        (index) => week
            .subtract(Duration(days: week.weekday - 1))
            .add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {});
        },
        itemBuilder: (context, index) {
          final weekStart = DateTime.now()
              .add(Duration(days: 7 * index - DateTime.now().weekday + 1));
          final weekDates = _getDaysInWeek(weekStart);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weekDates.map((date) {
              String dayName = DateFormat('EEE').format(date);
              String dayNumber = DateFormat('d').format(date);

              bool isSelected = selectedDate != null &&
                  selectedDate!.year == date.year &&
                  selectedDate!.month == date.month &&
                  selectedDate!.day == date.day;

              bool isCurrentDate = date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onDateTap(date),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    decoration: BoxDecoration(
                      color: (isSelected && widget.showHighlight)
                          ? ColorName.blue4
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(28),
                      border: (isCurrentDate && widget.showHighlight)
                          ? Border.all(color: ColorName.blue4, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: (isSelected && widget.showHighlight)
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          dayNumber,
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: (isSelected && widget.showHighlight)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
