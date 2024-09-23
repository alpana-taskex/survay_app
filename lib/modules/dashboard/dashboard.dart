import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/components/custom_date_range_picker.dart';
import 'package:crew_app/components/custom_input_widgets.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/modules/dashboard/dashboard_controller.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/utils/common_widget.dart';
import 'package:crew_app/widgets/bottombar.dart';
import 'package:crew_app/widgets/custom_checkboxl_ist_tile.dart';
import 'package:crew_app/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.notification),
            icon: Assets.svgs.iconNotification.svg(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      controller: controller.searchController,
                      height: 48,
                      borderColor: ColorName.gray11,
                      fillColor: Colors.transparent,
                      onClear: () {
                        controller.searchController.clear();
                      },
                      contentPadding: EdgeInsets.zero,
                      label: 'Search..',
                      maxLines: 1,
                      prefixIcon: const Icon(
                        TablerIcons.search,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              height: 36,
              child: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicatorColor: ColorName.blue3,
                labelColor: ColorName.blue3,
                tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            Flexible(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildJobList(controller.todayPagingController),
                  _buildJobList(controller.upcomingPagingController),
                  _buildJobList(controller.completedPagingController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobList(PagingController<int, CompleteJob> pagingController) {
    return RefreshIndicator(
      backgroundColor: ColorName.blue3,
      color: ColorName.white,
      onRefresh: () async {
        return await controller.onRefresh(pagingController);
      },
      child: PagedListView<int, CompleteJob>(
        padding: const EdgeInsets.only(top: 16),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<CompleteJob>(
          itemBuilder: (context, job, index) => jobCard(job),
          firstPageProgressIndicatorBuilder: (context) =>
              customLoadingIndicator(content: getJobLoadingWidget()),
          newPageProgressIndicatorBuilder: (context) =>
              customLoadingIndicator(content: getJobLoadingWidget()),
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Something went wrong'),
                ElevatedButton(
                  style: const ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () => pagingController.refresh(),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.svgs.iconEmpty.svg(),
                  vPad12,
                  Text(
                    "It looks like you have no ongoing jobs at the moment. You're all caught up!",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorName.gray3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget jobCard(CompleteJob job) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () => Get.toNamed(Routes.job, arguments: {
          'jobId': job.sId,
          'selectedTab': controller.tabController.index,
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Moving',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorName.black,
                    height: 2.4,
                  ),
                ),
              ],
            ),
            _buildTextRow('Job ID:', '${job.orderId}'),
            vPad6,
            _buildTextRow('Customer Name:', '${job.customerName}',
                color: ColorName.black),
            vPad6,
            Text('${job.totalTrucks} Truck • ${job.totalMen} Men'),
            vPad8,
            _buildAddressRow(Assets.svgs.iconOrigin.svg(),
                job.pickupFullAddress?.first.address ?? ''),
            vPad6,
            _buildAddressRow(Assets.svgs.iconDestination.svg(),
                job.dropoffFullAddress?.first.address ?? ''),
            if (controller.tabController.index == 0) ...[]
          ],
        ),
      ),
    );
  }

  Widget _buildAddressRow(Widget icon, String address) {
    return Row(
      children: [
        icon,
        hPad8,
        Expanded(
          child: Text(
            address,
            style: Get.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorName.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextRow(String title, String subtitle,
      {Color color = ColorName.gray3}) {
    return RichText(
      text: TextSpan(
        text: '$title ',
        style: Get.textTheme.bodySmall!.copyWith(
          color: ColorName.gray7,
          height: 2,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: subtitle,
            style: Get.textTheme.bodySmall!.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
