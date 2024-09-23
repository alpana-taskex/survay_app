import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/term_and_condition/term_and_condition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermAndCondition extends GetView<TermAndConditionController> {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding:
          const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 18),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TERMS AND CONDITIONS",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorName.blue1,
                  decoration: TextDecoration.underline,
                ),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Assets.svgs.iconCross.svg(),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 23),
            child: Column(
              children: [
                _buildTermItem('1. Acceptance of Terms',
                    'By using the Movermate Crew app, you agree to comply with and be bound by these terms and conditions. If you do not agree, do not use the app.'),
                _buildTermItem('2. User Responsibilities',
                    'Crew members must use the app solely for work-related purposes. Unauthorized use of the app is strictly prohibited.'),
                _buildTermItem('3. Account Security',
                    'Keep your login credentials confidential. You are responsible for all activities that occur under your account.'),
                _buildTermItem('4. Work Assignments',
                    'Job assignments and schedules provided through the app must be followed accurately. Any discrepancies or issues should be reported to your supervisor immediately.'),
                _buildTermItem('5. Data Privacy',
                    'Personal information and data collected through the app are used solely for job management and operational purposes. For more details, please review our Privacy Policy.'),
                _buildTermItem('6. Location Tracking',
                    'The app may use location services to provide real-time updates on job status. By using the app, you consent to this tracking while on duty.'),
                _buildTermItem('7. Communication',
                    'All communication through the app should be professional and related to work tasks. Inappropriate or unprofessional conduct will not be tolerated.'),
                _buildTermItem('8. Performance Monitoring',
                    'The app may monitor performance metrics to ensure efficient job completion. This data will be used to improve operations and provide feedback.'),
                _buildTermItem('9. Termination of Access',
                    'Access to the Movermate Crew app may be revoked at any time for violations of these terms, misconduct, or at the discretion of management.'),
                _buildTermItem('10. Changes to Terms',
                    'Movermate reserves the right to update these terms and conditions at any time. Continued use of the app after any changes constitutes your acceptance of the new terms.'),
                vPad24,
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(String title, String content) {
    return RichText(
      text: TextSpan(
        style: Get.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400,
          color: ColorName.black,
          height: 1.8,
          letterSpacing: 0
        ),
        children: [
          TextSpan(
            text: '$title ',
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorName.black,
              height: 2.0,
              letterSpacing: 0,
            ),
          ),
          TextSpan(text: content),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 168,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.white,
            border: Border.all(color: ColorName.gray11),
          ),
        ),
        vPad18,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorName.blue1.withOpacity(0.05),
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                overlayColor: Colors.transparent,
                foregroundColor: ColorName.blue1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(80, 32),
                textStyle: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  height: 2.2,
                ),
              ),
              child: const Text('Clear'),
            ),
            hPad14,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorName.blue1,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                overlayColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(80, 32),
                textStyle: Get.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal, height: 2.4),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
