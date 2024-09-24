import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCalendar extends StatefulWidget {
  final RxList<DateTime>
      selectedDates; // Changed to RxList to support multiple dates
  final Function(DateTime) onDateSelected;

  const CustomCalendar({
    super.key,
    required this.selectedDates,
    required this.onDateSelected,
  });

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  final PageController _pageController = PageController(initialPage: 1);
  final RxInt _currentMonthIndex = 1.obs; // Default to the current month
  final DateTime _currentDate = DateTime.now();

  DateTime _getMonthDate(int monthOffset) {
    return DateTime(_currentDate.year, _currentDate.month + monthOffset, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Calculate the date based on the current month index
      _getMonthDate(_currentMonthIndex.value - 1);

      return Column(
        children: [
          // PageView for swiping between months
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                _currentMonthIndex.value = index;
              },
              itemCount: 3, // Previous month, current month, next month
              itemBuilder: (context, index) {
                DateTime currentMonth = _getMonthDate(index - 1);
                return _buildCalendar(currentMonth);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCalendar(DateTime monthDate) {
    DateTime startDate = DateTime(monthDate.year, monthDate.month, 1);
    int daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;
    int firstWeekdayOfMonth = startDate.weekday;

    List<Widget> dayWidgets = [];

    // Get the previous month details
    DateTime previousMonth = DateTime(monthDate.year, monthDate.month - 1);
    int daysInPreviousMonth =
        DateTime(previousMonth.year, previousMonth.month + 1, 0).day;

    // Add previous month's dates in the empty slots
    int previousMonthDayStart =
        daysInPreviousMonth - (firstWeekdayOfMonth % 7) + 1;
    for (int i = 0; i < firstWeekdayOfMonth % 7; i++) {
      dayWidgets.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 0.1),
          ),
          child: Text(
            (previousMonthDayStart + i).toString(),
            style: const TextStyle(
              color: Colors.grey, // Grayed out
            ),
          ),
        ),
      );
    }

    // Add the current month's days
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime dayDate = DateTime(monthDate.year, monthDate.month, day);
      bool isSelected = widget.selectedDates.any((selectedDate) =>
          selectedDate.year == dayDate.year &&
          selectedDate.month == dayDate.month &&
          selectedDate.day == dayDate.day);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedDates.removeWhere((selectedDate) =>
                    selectedDate.year == dayDate.year &&
                    selectedDate.month == dayDate.month &&
                    selectedDate.day == dayDate.day);
              } else {
                widget.selectedDates.add(dayDate);
              }
            });
            widget.onDateSelected(dayDate);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 0.2),
              color: isSelected ? ColorName.blue4 : Colors.transparent,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(7, (index) {
            return Center(
              child: Text(
                ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index],
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }),
        ),
        vPad8,
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: dayWidgets,
        ),
      ],
    );
  }
}
