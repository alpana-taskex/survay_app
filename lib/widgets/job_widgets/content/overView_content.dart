import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/widgets/job_widgets/button/overView_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewContent extends StatelessWidget {
  final CompleteJob job;
  final int index;

  const OverViewContent({
    super.key,
    required this.job,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: ColorName.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowSection(
                firstTitle: 'Job Date',
                firstContent: formatDateTime(job.moveDate.toString()),
                secondTitle: 'Preferred Time Slot',
                secondContent: job.timing ?? '',
              ),
              vPad12,
              _buildRowSection(
                firstTitle: 'Move Size',
                firstContent: job.movesize.toString(),
                secondTitle: 'Furnish Type',
                secondContent: job.funishedType.toString(),
              ),
              vPad12,
              _buildRowSection(
                firstTitle: index != 2 ? 'Est Start Time' : 'Act Start Time',
                firstContent: formatDateTime(job.jobStartTime.toString(),
                    date: false, time: true),
                secondTitle: index != 2 ? 'Est End Time' : 'Act End Time',
                secondContent: formatDateTime(job.jobEndTime.toString(),
                    date: false, time: true),
              ),
              vPad12,
              Text(
                'Additional Notes',
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
              vPad4,
              Text(
                job.bookingNotes ?? "NA",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: ColorName.black,
                ),
              ),
              vPad14,
              Text(
                'Assigned Trucks',
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
              vPad2,
              ListView.builder(
                shrinkWrap: true,
                itemCount: job.trucks?.length ?? 0,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      _buildTruckTile(
                        widget: Assets.svgs.iconTruck.svg(),
                        text: job.trucks?[i].vehicleName ?? '',
                        secondText: job.trucks?[i].capacityinTons ?? '',
                      ),
                    ],
                  );
                },
              ),
              vPad9,
              Text(
                'Assigned Movers',
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
              vPad4,
              ListView.builder(
                shrinkWrap: true,
                itemCount: job.employees?.length ?? 0,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      _buildTruckTile(
                        widget: Assets.svgs.iconPersonBlack.svg(),
                        text: job.employees?[i].name ?? '',
                        secondText: job.employees?[i].department ?? '',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        spacer,
        _buildButtonSection()
      ],
    );
  }

  Widget _buildRowSection({
    required String firstTitle,
    required String firstContent,
    required String secondTitle,
    required String secondContent,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: ColorName.gray6,
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
              vPad4,
              Text(
                firstContent,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: ColorName.black,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                secondTitle,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: ColorName.gray6,
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
              vPad4,
              Text(
                secondContent,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: ColorName.black,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTruckTile({
    required Widget widget,
    required String text,
    required String secondText,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: Row(
        children: [
          widget,
          hPad8,
          Text(
            text,
            style: Get.textTheme.bodyMedium!.copyWith(
              color: ColorName.black,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
          hPad8,
          Container(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: ColorName.blue10,
            ),
            child: Text(
              secondText,
              style: Get.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w500,
                height: 2.4,
                letterSpacing: 0,
                color: ColorName.blue3,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildButtonSection(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: const BoxDecoration(
        color: ColorName.white,
        border: Border(top: BorderSide(color: ColorName.gray10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(327, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: /*job.jobPaused.value
                        ? ColorName.blue12 // White background when paused
                        : */ColorName.blue4, // Blue background when not paused
              ),
              child: Text(
                'Pause',
                style: Get.theme.textTheme.titleLarge!.copyWith(
                  color: /*job.jobPaused.value
                          ? ColorName.blue1 // Blue text when paused
                          : */ColorName.white, // White text when not paused
                ),
              ),
            ),
          ),
          hPad8,
          Expanded(
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(327, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: /*job.jobPaused.value
                        ? ColorName.blue4 // Blue background when paused
                        : */ColorName.blue12, // White background when not paused
              ),
              child: Text(
                'Resume Job',
                style: Get.theme.textTheme.titleLarge!.copyWith(
                  color: /*job.jobPaused.value
                          ? ColorName.white // White text when paused
                          :*/ ColorName.blue1, // Blue text when not paused
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
