
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

class Dashboard extends GetView<DashboardController>  {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          vPad32,
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Assets.svgs.chainLogo.svg(),
                    spacer,
                    IconButton.outlined(
                      style: IconButton.styleFrom(
                        highlightColor: Colors.transparent,
                        fixedSize: const Size(48, 48),
                        side: const BorderSide(
                            color: ColorName.gray11, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Get.toNamed(Routes.notification),
                      icon: Assets.svgs.iconNotification.svg(),
                    ),
                  ],
                ),
                vPad16,
                Row(
                  children: [
                    Expanded(
                      child: TextInputField(
                        controller: controller.searchController,
                        height: 48,
                        borderColor: ColorName.gray11,
                        fillColor: Colors.transparent,
                        onClear: (){
                          controller.searchController.clear();
                        },
                        contentPadding: EdgeInsets.zero,
                        label: 'Search..',
                        maxLines: 1,
                        prefixIcon: const Icon(
                          TablerIcons.search,
                          size: 20,
                        ),
                        onChanged: controller.onSearchChanged,
                      ),
                    ),
                    hPad16,
                    Obx(() => IconButton.outlined(
                          onPressed: () => controller
                              .openFilterBottomSheet(filterSheet(context)),
                          style: IconButton.styleFrom(
                            fixedSize: const Size(48, 48),
                            side: BorderSide(
                              color: controller.isAnyFilterActive.value
                                  ? ColorName.blue3
                                  : ColorName.gray11,
                              width: 1.5,
                            ),
                            highlightColor: Colors.transparent,
                            foregroundColor: ColorName.blue3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(TablerIcons.adjustments_horizontal),
                        ))
                  ],
                ),
                vPad16,
                SizedBox(
                  width: Get.width,
                  height: 36,
                  child: TabBar(
                    controller: controller.tabController,
                    tabAlignment: TabAlignment.start,

                    isScrollable: true,
                    dividerColor: ColorName.blue11,
                    indicatorColor: ColorName.blue3,
                    labelColor: ColorName.blue3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.only(right: 20),
                    indicatorPadding: const EdgeInsets.only(right: 18 ),
                    indicatorWeight: 2.5,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashBorderRadius: BorderRadius.circular(40),
                    labelStyle: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorName.blue3,
                    ),
                    tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
                  ),
                ),
              ],
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
                if (controller.tabController.index != 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: controller.getStatusColor(job.status ?? ''),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      job.status ?? '',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: ColorName.white,
                        height: 2.4,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
              ],
            ),
            _buildTextRow('Job ID:', '${job.orderId}'),
            vPad6,
            _buildTextRow('Customer Name:', '${job.customerName}',
                color: ColorName.black),
            vPad6,
            _buildTextRow(
              'Date:',
              job.moveDate != null
                  ? DateTime.parse(job.moveDate!).hour == 0 &&
                          DateTime.parse(job.moveDate!).minute == 0
                      ? DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(job.moveDate!))
                      : DateFormat('dd MMMM yyyy (HH:mm a)')
                          .format(DateTime.parse(job.moveDate!))
                  : '',
              color: ColorName.black,
            ),
            vPad6,
            Text('${job.totalTrucks} Truck • ${job.totalMen} Men'),
            vPad8,
            _buildAddressRow(Assets.svgs.iconOrigin.svg(),
                job.pickupFullAddress?.first.address ?? ''),
            vPad6,
            _buildAddressRow(Assets.svgs.iconDestination.svg(),
                job.dropoffFullAddress?.first.address ?? ''),
            if (controller.tabController.index == 0) ...[
              vPad16,
              CommonWidget.dividerWidget(
                  width: Get.width, thickness: 1, color: ColorName.gray9),
              vPad12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => _buildActionButton(
                      Assets.svgs.iconCall.svg(),
                      'Call Customer',
                      () {
                        Get.bottomSheet(callSheet('+61 ${job.mobilePhone}'),
                            isDismissible: false);
                        controller.isCallButtonActive.value = true;
                      },
                      isActive: controller.isCallButtonActive.value,
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                    ),
                  ),
                  CommonWidget.dividerWidget(
                      width: 1, thickness: 36, color: ColorName.gray9),
                  _buildActionButton(
                    Assets.svgs.iconNavigation.svg(),
                    'Navigate',
                    () => controller.launchMapWithWaypoints(job),
                    isActive: false,
                    padding: const EdgeInsets.all(6),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAddressRow(Widget svgWidget, String address) {
    return Row(
      children: [
        svgWidget,
        hPad8,
        Expanded(
          child: Text(
            address,
            style: Get.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.normal,
              color: ColorName.black,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    Widget svgWidget,
    String label,
    VoidCallback onPressed, {
    EdgeInsets? padding,
    bool isActive = false,
  }) {
    return OutlinedButton.icon(
      icon: svgWidget,
      label: Text(
        label,
        style: Get.textTheme.bodySmall!.copyWith(
          color: ColorName.blue3,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        overlayColor: Colors.transparent,
        fixedSize: const Size(132, 36),
        padding: padding ?? EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: ColorName.blue3,
        side: BorderSide(color: isActive ? ColorName.blue3 : ColorName.gray10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Widget _buildTextRow(
    String firstName,
    String secondName, {
    Color? color,
  }) {
    return Row(
      children: [
        Text(
          '$firstName ',
          style: Get.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          secondName,
          style: Get.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.normal,
            color: color ?? ColorName.gray7,
          ),
        ),
      ],
    );
  }

  Widget filterSheet(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CommonWidget.dividerWidget(
              width: 60,
              thickness: 5,
              round: 100,
              color: ColorName.gray11,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorName.blue3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          CommonWidget.dividerWidget(
              width: Get.width, thickness: 1, color: ColorName.gray10),
          vPad12,
          Text(
            'Date',
            style: Get.textTheme.bodyMedium!.copyWith(
              color: ColorName.gray6,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.6,
            ),
          ),
          vPad4,
          Obx(() {
            final start = controller.dateRange.value?.start;
            final end = controller.dateRange.value?.end;

            String displayText = 'Select';
            if (start != null && end != null) {
              displayText =
                  '${DateFormat('d MMM yyyy').format(start)} - ${DateFormat('d MMM yyyy').format(end)}';
            }

            return InkWell(
              onTap: () async {
                final result = await showDialog<DateTimeRange?>(
                  context: context,
                  builder: (BuildContext context) => CustomDateRangePicker(
                    initialDateRange: controller.dateRange.value,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                    selectedColor: ColorName.blue3,
                  ),
                );
                controller.setCustomDateRange(result);
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.fromLTRB(16, 9.8, 16, 9.8),
                decoration: BoxDecoration(
                  color: ColorName.blue3.withOpacity(.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      displayText,
                      style: TextStyle(
                        color: controller.isCustomDateFilterApplied.value
                            ? ColorName.black
                            : ColorName.gray6,
                      ),
                    ),
                    Assets.svgs.iconCalendar.svg(),
                  ],
                ),
              ),
            );
          }),
          vPad12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Job Types',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorName.gray6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.6,
                ),
              ),
              Obx(
                () => TextButton(
                  onPressed: controller.clearAllFilters,
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    'Clear All',
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: controller.isAnyFilterActive.value
                          ? ColorName.blue3
                          : ColorName.gray6,
                      fontWeight: FontWeight.normal,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          vPad6,
          Obx(
            () => Column(
              children: controller.filterOptions.value['jobTypes']
                      ?.map((option) => CustomCheckboxTile(
                            title: option['label'] ?? '',
                            value:
                                controller.selectedFilters[option['value']] ??
                                    false,
                            onChanged: (newValue) =>
                                controller.toggleFilter(option['value'] ?? ''),
                          ))
                      .toList() ??
                  [],
            ),
          ),
          vPad14,
          InputButton(
            isLoading: controller.isLoading.value,
            onPressed: controller.applyFilter,
            label: 'Apply Now',
          ),
          vPad16,
        ],
      ),
    );
  }

  Widget callSheet(String phone) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              Uri uri =
                  Uri.parse('tel:$phone'); // Parse the string to a Uri object
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not launch $phone';
              }
            },
            icon: Assets.svgs.iconCallFilled.svg(),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(Get.width, 44),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: ColorName.blue4,
            ),
            label: Text(
              'Call: $phone',
              style: Get.textTheme.bodyLarge!.copyWith(
                color: ColorName.white,
              ),
            ),
          ),
          vPad18,
          SizedBox(
            height: 44,
            child: InputButton(
              backgroundColor: ColorName.blue12,
              elevation: 0,
              labelColor: ColorName.blue3,
              onPressed: () {
                controller.isCallButtonActive.value = false;
                Get.back();
              },
              label: 'Cancel',
            ),
          )
        ],
      ),
    );
  }
}
