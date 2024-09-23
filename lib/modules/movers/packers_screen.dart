import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/movers/movers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackersScreen extends GetView<MoversController> {
  const PackersScreen({super.key});

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith();
    final textColor = theme.textTheme.bodyLarge!.color;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container()/*Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Assets.svgs.iconBackArrow.svg(),
              ),
              const SizedBox(
                width: 90,
              ),
              Obx(
                () => Text(
                  controller.job.value.jobId,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )*/,
      ),
      body: Container()/*Obx(
        () {
          final job = controller.job.value;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      job.assignedMovers.isNotEmpty ? job.assignedMovers[0].name : 'No Movers',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            CupertinoIcons.phone_fill,
                            color: ColorName.blue4,
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: Icon(
                            CupertinoIcons.chat_bubble_fill,
                            color: ColorName.blue4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ADDRESS'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorName.blue12,
                      ),
                      child: const Text(
                        '0hr 0mins',
                        style: TextStyle(color: ColorName.blue4),
                      ),
                    ),
                  ],
                ),
                if (job.addresses.isNotEmpty)
                  ListTile(
                    minTileHeight: 10,
                    minVerticalPadding: 8,
                    horizontalTitleGap: 0.0,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Assets.svgs.iconOrigin.svg(),
                    title: Text(
                      '${job.addresses[0].street}, ${job.addresses[0].city}, ${job.addresses[0].state} ${job.addresses[0].postcode}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: textColor,
                      ),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      color: ColorName.blue4,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTabItem('OVERVIEW', 0),
                    _buildTabItem('ESTIMATE', 1),
                    _buildTabItem('MEDIA', 2),
                    _buildTabItem('SIGN', 3),
                    _buildTabItem('INVENTORY', 4),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: _buildContent(),
                ),
                const Text('Additional Notes'),
                Text(
                  job.additionalNotes.isEmpty ? 'NA' : job.additionalNotes,
                  style: const TextStyle(
                    color: ColorName.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Assigned Packers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...job.assignedPackers.map(
                      (packer) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.person_alt, color: Colors.black54),
                            const SizedBox(width: 8),
                            Text(
                              packer.name,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                // color: Colors.lightBlue.shade50,
                                color: ColorName.blue8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                packer.role,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      )*/,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: ColorName.gray10),
            ),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(0),
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 16)),
                backgroundColor: const WidgetStatePropertyAll(ColorName.blue4),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
            onPressed: controller.startJob,
            child: const Text(
              'Start Job',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedIndex.value = index;
        },
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: controller.selectedIndex.value == index ? ColorName.blue6 : Colors.grey,
                fontWeight: controller.selectedIndex.value == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (controller.selectedIndex.value == index)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 50,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (controller.selectedIndex.value) {
      case 0:
        return _buildOverviewContent();
      case 1:
        return _buildEstimateContent();
      case 2:
        return _buildMediaContent();
      case 3:
        return _buildSignContent();
      case 4:
        return _buildInventoryContent();
      default:
        return _buildOverviewContent();
    }
  }

  Widget _buildOverviewContent() {
    return Obx(() {
      final job = controller.job.value;

      return Container();/*Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job Date',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatDate(job.jobDate),
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Move Size',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        job.moveSize,
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Est Start Time',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatTime(job.estStartTime),
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preferred Time Slot',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        job.preferredTimeSlot,
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Furnish Type',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        job.furnishType,
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Est End Time',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatTime(job.estEndTime),
                        style: const TextStyle(
                          color: ColorName.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );*/
    });
  }

  Widget _buildEstimateContent() {
    return const Center(
      child: Text('No upcoming jobs.'),
    );
  }

  Widget _buildMediaContent() {
    return const Center(
      child: Text('No completed jobs.'),
    );
  }

  Widget _buildSignContent() {
    return const Center(
      child: Text('No completed jobs.'),
    );
  }

  Widget _buildInventoryContent() {
    return const Center(
      child: Text('No completed jobs.'),
    );
  }
}
