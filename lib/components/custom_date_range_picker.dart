import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color selectedColor;
  final Color rangeColor;
  final Function(DateTime, DateTime)? onChanged;

  const CustomDateRangePicker({
    super.key,
    this.initialDateRange,
    required this.firstDate,
    this.onChanged,
    required this.lastDate,
    this.selectedColor = Colors.blue,
    this.rangeColor = ColorName.blue12,
  });

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTime? _startDate;
  late DateTime? _endDate;
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialDateRange?.start;
    _endDate = widget.initialDateRange?.end;
    _focusedDate = _startDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        backgroundColor: Colors.white,
        onClosing: () {},
        builder: (context) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            constraints: BoxConstraints(
              maxWidth: Get.width,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const Divider(),
                _buildCalendar(),
                _buildFooter(),
              ],
            ),
          );
        });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _focusedDate =
                  DateTime(_focusedDate.year, _focusedDate.month - 1);
            });
          },
        ),
        Text(
          DateFormat('MMMM yyyy').format(_focusedDate),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _focusedDate =
                  DateTime(_focusedDate.year, _focusedDate.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.9,
      ),
      itemCount: 42, // 6 weeks * 7 days
      itemBuilder: (context, index) {
        final MaterialLocalizations localizations =
            MaterialLocalizations.of(context);
        final int firstDayOffset = DateUtils.firstDayOffset(
          _focusedDate.year,
          _focusedDate.month,
          localizations,
        );
        final int day = index - firstDayOffset + 1;
        if (day < 1 ||
            day >
                DateUtils.getDaysInMonth(
                    _focusedDate.year, _focusedDate.month)) {
          return Container();
        }
        final date = DateTime(_focusedDate.year, _focusedDate.month, day);
        return _buildDayCell(date);
      },
    );
  }

  Widget _buildDayCell(DateTime date) {
    final bool isStart =
        _startDate != null && date.isAtSameMomentAs(_startDate!);
    final bool isEnd = _endDate != null && date.isAtSameMomentAs(_endDate!);
    final bool isInRange = _startDate != null &&
        _endDate != null &&
        date.isAfter(_startDate!) &&
        date.isBefore(_endDate!);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _selectDate(date),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: isStart
              ? const BorderRadius.only(
                  topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))
              : isEnd
                  ? const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4))
                  : null,
          color: isStart || isEnd
              ? widget.selectedColor
              : isInRange
                  ? widget.rangeColor
                  : null,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isStart || isEnd ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(DateTime date) {
    setState(() {
      if (_startDate == null ||
          _endDate != null ||
          date.isBefore(_startDate!)) {
        _startDate = date;
        _endDate = null;
      } else {
        _endDate = date;
      }
    });
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InputButton(
            labelColor: ColorName.blue3,
            elevation: 0,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            onPressed: () {
              Get.back(result: null);
              _startDate = null;
              _endDate = null;
            },
            label: 'Clear',
          ),
        ),
        hPad16,
        Expanded(
          child: InputButton(
            onPressed: () {
              if (_startDate != null && _endDate != null) {
                Get.back(
                    result: DateTimeRange(
                  start: _startDate!,
                  end: _endDate!,
                ));
              } else if (_startDate != null) {
                Get.back(
                    result: DateTimeRange(
                  start: _startDate!,
                  end: _startDate!,
                ));
              } else {
                Get.back(result: null);
              }
            },
            label: 'Apply',
          ),
        ),
      ],
    );
  }
}
