import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class AvailabilityController extends BaseController {
  RxBool isWeekly = false.obs;
  RxList<DateTime> selectedDates = <DateTime>[].obs; // Updated to handle multiple dates
  RxList<bool> selectedWeekdays = List.filled(7, false).obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxString selectedShift = ''.obs;

  void toggleRecurrence(bool value) {
    isWeekly.value = value;
  }

  void toggleDateSelection(DateTime date) {
    if (selectedDates.contains(date)) {
      selectedDates.remove(date); // Remove date if already selected
    } else {
      selectedDates.add(date); // Add date if not selected
    }
  }

  void toggleWeekday(int index) {
    selectedWeekdays[index] = !selectedWeekdays[index];
  }

  void setStartDate(DateTime date) {
    startDate.value = date;
  }

  void setEndDate(DateTime? date) {
    endDate.value = date;
  }

  void confirmAvailability() {
    // Handle the confirmation logic
  }
}
