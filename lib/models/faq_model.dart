import 'package:get/get.dart';

class FAQModel {
  final String question;
  final String answer;
  RxBool isExpanded;

  FAQModel({required this.question, required this.answer, bool expanded = false})
      : isExpanded = expanded.obs;
}