import 'package:crew_app/models/faq_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class FaqController extends BaseController {
  final RxList<FAQModel> faqItems = <FAQModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFAQs();
  }

  void loadFAQs() {
    faqItems.assignAll([
      FAQModel(
        question: "How do I start a moving job?",
        answer: "Once you receive a job assignment, navigate to the \"Jobs\" tab in the app. Select the assigned job and click \"Start Job\" to begin.",
        expanded: true,
      ),
      FAQModel(
        question: "How can I update the job status?",
        answer: "You can update the job status within the job details screen. Look for an 'Update Status' option or similar functionality.",
      ),
      FAQModel(
        question: "What should I do if I encounter an issue during a job?",
        answer: "If you encounter any issues, immediately contact your supervisor or use the in-app support feature to report the problem.",
      ),
      FAQModel(
        question: "How do I access the job details?",
        answer: "Job details can be accessed by selecting the specific job from your job list in the app.",
      ),
      FAQModel(
        question: "Can I communicate with the customer through the app?",
        answer: "Yes, most moving apps provide a messaging feature to communicate with customers. Check your app's interface for a messaging or chat option.",
      ),
      FAQModel(
        question: "How do I complete a job?",
        answer: "To complete a job, go to the job details screen and look for a 'Complete Job' or 'Finish' button. Follow the prompts to mark the job as completed.",
      ),
      FAQModel(
        question: "When will my earnings be available in the wallet?",
        answer: "Earnings are typically processed within 1-3 business days after job completion. Check your app's payment section for specific payout schedules.",
      ),
    ]);
  }

  void toggleExpansion(int index) {
    faqItems[index].isExpanded.toggle();
  }
}