import 'package:get/get.dart';

class LanguageController extends GetxController {
  final selectedLanguage = RxString('English');
  final languages = [
    {'name': 'English', 'sample': 'Aa'},
    {'name': 'Portuguese', 'sample': 'Àà'},
    // Add more languages here
  ];

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = 'English';
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
  }
}