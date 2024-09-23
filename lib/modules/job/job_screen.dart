import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/shared/utils/common_widget.dart';
import 'package:crew_app/widgets/job_widgets/content/inventory_content.dart';
import 'package:crew_app/widgets/job_widgets/content/media_content.dart';
import 'package:crew_app/widgets/job_widgets/content/overView_content.dart';
import 'package:crew_app/widgets/job_widgets/content/sign_content.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'job_controller.dart';

class JobScreen extends GetView<JobController> {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar:
              appBar(title: controller.job.value?.orderId?.toUpperCase() ?? ''),
          body: controller.job.value == null
              ? customLoadingIndicator(
                  children: 5, padding: const EdgeInsets.only(top: 16))
              : Column(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.job.value?.customerName ??
                                        'No Movers',
                                    maxLines: 1,
                                    style:
                                        Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: ColorName.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: controller.call,
                                        child: const CircleAvatar(
                                          child: Icon(
                                            CupertinoIcons.phone_fill,
                                            color: ColorName.blue4,
                                          ),
                                        ),
                                      ),
                                      hPad12,
                                      InkWell(
                                        onTap: controller.message,
                                        child: const CircleAvatar(
                                          child: Icon(
                                            CupertinoIcons.chat_bubble_fill,
                                            color: ColorName.blue4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              vPad12,
                              CommonWidget.dividerWidget(
                                  width: Get.width,
                                  color: ColorName.gray10,
                                  thickness: 1),
                              vPad12,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ADDRESS',
                                    style:
                                        Get.theme.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      height: 1.6,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 0, 6, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: ColorName.blue12,
                                    ),
                                    child: Text(
                                      controller.job.value?.timing ??
                                          '0hr 0mins',
                                      style: Get.theme.textTheme.labelSmall!
                                          .copyWith(
                                        color: ColorName.blue4,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                        height: 2.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _buildDestinationSection(controller.job.value),
                            ],
                          ),
                        ),
                        vPad12,
                        SizedBox(
                          width: Get.width,
                          height: 32,
                          child: TabBar(
                            controller: controller.tabController,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            dividerColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            indicatorColor: ColorName.blue3,
                            labelColor: ColorName.blue3,
                            indicatorWeight: 2,
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            splashBorderRadius: BorderRadius.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelStyle: Get.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorName.blue3,
                            ),
                            tabs: const [
                              Tab(text: 'OVERVIEW'),
                              Tab(text: 'ESTIMATE'),
                              Tab(text: 'MEDIA'),
                              Tab(text: 'SIGN'),
                              Tab(text: 'INVENTORY'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                OverViewContent(
                                  job: controller.job.value ?? CompleteJob(),
                                  index: Get.arguments['selectedTab'],
                                ),
                                _buildEstimateContent(),
                                MediaContent(controller: controller),
                                SignContent(controller: controller),
                                InventoryContent(controller: controller),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    // Obx(() => _buildBottomWidget()), // Dynamically build bottom widget
                  ],
                ),
        ));
  }

  Widget _buildEstimateContent() {
    final List<Estimate> estimateItems = controller.job.value?.estimate ?? [];

    if (estimateItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorName.blue12,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
              vPad16,
              Text(
                "Tap the '+' icon to create an estimate.",
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: ColorName.black,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildEstimateTable(estimateItems),
            const SizedBox(height: 16.0),
            _buildTotalSection(estimateItems),
          ],
        ),
      );
    }
  }

  Widget _buildEstimateTable(List<Estimate> items) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('DESCRIPTION',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('RATE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('QTY', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('TAX', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('SUBTOTAL',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        ...items.map((item) {
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${item.description}'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$${item.rate?.toStringAsFixed(2)}'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.qty.toString()),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.tax ?? 'NA'),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$${item.totalamount?.toStringAsFixed(2)}'),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTotalSection(List<Estimate> items) {
    double subtotal =
        items.fold(0.0, (sum, item) => sum + (item.totalamount ?? 0));
    double tax =
        items.fold(0.0, (sum, item) => sum + sum * (item.taxpercentage ?? 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '\$${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tax',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '\$${tax.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'GRAND TOTAL',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${(subtotal + tax).toStringAsFixed(2)}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDestinationSection(CompleteJob? job) {
    return Column(
      children: [
        _buildDestinationTile(
          widget: Assets.svgs.iconOrigin.svg(),
          text: job?.pickupAddress.toString() ?? '',
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.dividerWidget(
                width: 1, thickness: 16, color: ColorName.blue1),
          ),
        ),
        _buildDestinationTile(
          widget: Assets.svgs.iconDestination.svg(),
          text: job?.dropoffAddress.toString() ?? '',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildDestinationTile(
      {required Widget widget, required String text, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          widget,
          hPad6,
          Text(
            text,
            maxLines: 1,
            style: Get.theme.textTheme.bodyMedium!.copyWith(
              color: ColorName.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          spacer,
          const Icon(
            CupertinoIcons.chevron_forward,
            color: ColorName.blue4,
          ),
        ],
      ),
    );
  }
}
