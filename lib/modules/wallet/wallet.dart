import 'package:crew_app/components/custom_date_range_picker.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/wallet_job_model.dart';
import 'package:crew_app/modules/wallet/wallet_controller.dart';
import 'package:crew_app/shared/utils/common_widget.dart';
import 'package:crew_app/widgets/bottombar.dart';
import 'package:crew_app/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Wallet extends GetView<WalletController> {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 170),
        child: Container(
          margin: const EdgeInsets.only(top: 56),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Wallet",
            style: Get.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && !controller.hasInitialJobs.value) {
          return Center(child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: customLoadingIndicator(content: getJobLoadingWidget(height: 150, children: 6)),
          ));
        } else {
          return RefreshIndicator(
            backgroundColor: ColorName.blue3,
            color: ColorName.white,
            onRefresh: controller.onRefresh,
            child: Column(
              children: [
                _buildEarningsCard(context),
                Expanded(
                  child: _buildJobList(),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildJobList() {
    if (!controller.hasInitialJobs.value) {
      return _buildEmpty();
    } else if (controller.isFiltering.value) {
      return Center(child: customLoadingIndicator());
    } else if (controller.allJobs.isEmpty) {
      return _buildFilteredEmpty();
    } else {
      return PagedListView<int, WalletJob>(
        pagingController: controller.pagingController,
        physics: const AlwaysScrollableScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<WalletJob>(
          newPageProgressIndicatorBuilder: (BuildContext context) =>
              customLoadingIndicator(),
          noMoreItemsIndicatorBuilder: (context) => vPad22,
          firstPageProgressIndicatorBuilder: (BuildContext context) =>
              customLoadingIndicator(),
          itemBuilder: (context, job, index) {
            return _buildJobItem(job);
          },
        ),
      );
    }
  }

  Widget _buildEarningsCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: ColorName.blue12.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Earnings',
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: ColorName.gray8,
                      height: 1.6,
                    ),
                  ),
                  vPad16,
                  Text(
                    '\$${controller.wallet.value?.wallet?.totalEarnings?.toStringAsFixed(2) ?? '0.00'}',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: ColorName.black,
                      fontWeight: FontWeight.w600,
                      height: 0.38,
                      fontSize: 22,
                    ),
                  ),
                  vPad16,
                ],
              ),
              _buildDateRangePicker(context),
            ],
          ),
          vPad8,
          CommonWidget.dividerWidget(
              width: Get.width, thickness: 1, color: ColorName.gray10),
          vPad8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                  Assets.svgs.iconJobs.svg(),
                  '${controller.wallet.value?.wallet?.totalJobsCompleted ?? 0}',
                  'Total Jobs'),
              _buildInfoItem(
                  Assets.svgs.iconTime.svg(),
                  '${controller.wallet.value?.wallet?.totalHours?.toStringAsFixed(1) ?? '0.0'} hours',
                  'Total Hours'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () async {
        final result = await controller.openDateRangePicker(
          CustomDateRangePicker(
            initialDateRange: controller.dateRange.value,
            firstDate: DateTime(2024),
            lastDate: DateTime(2030),
            selectedColor: ColorName.blue3,
          ),
        );
        Logger().d(result);
        controller.updateDateRange(result);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.shouldShowBlueOutline
                ? ColorName.blue3
                : ColorName.gray10,
          ),
          color: ColorName.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.dateRangeText,
              style: Get.textTheme.bodySmall!.copyWith(
                color: ColorName.gray5,
              ),
            ),
            hPad12,
            Assets.svgs.iconCalendarSmall.svg(
                color: controller.shouldShowBlueOutline
                    ? ColorName.blue3
                    : ColorName.black),
          ],
        ),
      ),
    ));
  }


  Widget _buildInfoItem(Widget icon, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Get.textTheme.bodySmall!.copyWith(
            color: ColorName.gray8,
            height: 1.6,
          ),
        ),
        vPad2,
        Row(
          children: [
            icon,
            hPad8,
            Text(
              value,
              style: Get.textTheme.bodyMedium!.copyWith(color: ColorName.black),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobItem(WalletJob job) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: ColorName.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Job ID: ${job.job?.orderId}',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorName.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateFormat('d MMMM yyyy')
                    .format(DateTime.parse(job.job!.moveDate!)),
                style: Get.textTheme.bodySmall!.copyWith(
                  color: ColorName.gray6,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
            ],
          ),
          vPad12,
          CommonWidget.dividerWidget(
              width: Get.width, thickness: 1, color: ColorName.gray10),
          vPad12,
          Text(
            'Customer Name',
            style: Get.textTheme.bodySmall!.copyWith(
              color: ColorName.gray8,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),
          Text(
            job.job!.customerName!,
            style: Get.textTheme.bodySmall!.copyWith(
              color: ColorName.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          vPad8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildJobDetailItem(
                  'RATE', '\$${job.workPrice!.toStringAsFixed(2)}'),
              _buildJobDetailItem('TIME', '${job.jobTime} hr'),
              _buildJobDetailItem(
                  'EXTRAS', '\$${job.extra!.toStringAsFixed(2)}'),
              _buildJobDetailItem('TOTAL EARNINGS',
                  '\$${(job.workPrice! + job.extra!).toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.bodySmall!.copyWith(
            color: ColorName.gray8,
            fontSize: 10,
            height: 2.2,
            fontWeight: FontWeight.w500,
          ),
        ),
        vPad4,
        Text(
          value,
          style: Get.textTheme.bodySmall!.copyWith(
            color: ColorName.black,
            height: 1.8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.iconEmpty.svg(),
          vPad12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "No jobs have been completed yet, so there's nothing in your wallet. Complete a job to see your earnings here.",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorName.gray3,
                height: 1.6,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilteredEmpty() {
    return Center(
      child: Text(
        "No jobs found for the selected date range.",
        textAlign: TextAlign.center,
        style: Get.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorName.gray3,
          height: 1.6,
        ),
      ),
    );
  }
}
