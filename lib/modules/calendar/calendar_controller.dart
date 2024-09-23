import 'package:crew_app/models/schedule_item_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class CalendarController extends BaseController {
  RxInt selectedTabIndex = 1.obs;
  final selectedDate = DateTime.now().obs;

  void onValueChanged(val) {
    selectedTabIndex.value = val;
  }

  // Sample schedule data
  final List<ScheduleItemModel> scheduleItems = [
    ScheduleItemModel(
      date: DateTime(2024, 8, 20),
      customerName: 'Leslie Alexander',
      location: 'Adelaide-Perth',
      items: '3 Trucks',
      jobId: 'OZW38190',
      men: '2',
      timeRange: '04:45 PM - 07:45 PM',
    ),
    ScheduleItemModel(
      date: DateTime(2024, 8, 20),
      customerName: 'Guy Hawkins',
      location: 'Brisbane',
      items: '2 Packers',
      jobId: 'OZW23100',
      timeRange: '12:00 PM - 1:00 PM',
    ),
    ScheduleItemModel(
      date: DateTime(2024, 8, 21),
      customerName: 'Leslie Alexander',
      location: 'Adelaide-Perth',
      items: '3 Packers',
      jobId: 'OZW23100',
      timeRange: '2:00 PM - 3:00 PM',
    ),
  ];

}