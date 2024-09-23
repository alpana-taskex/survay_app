import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/invoice.dart';
import 'package:crew_app/widgets/styled_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/circle_painter.dart';
import 'invoice_controller.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.gray11))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Assets.svgs.iconBackArrow.svg(),
                  tooltip: 'Back',
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Invoice",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorName.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        final invoice = controller.invoice.value;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInvoiceHeader(invoice),
              vPad12,
              _buildCustomerDetails(invoice),
              vPad12,
              _buildInvoiceDetails(invoice),
              vPad12,
              _buildTotalDetails(invoice),
              vPad12,
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.only(top: 22, bottom: 24, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: ColorName.white,
          border: Border(
            top: BorderSide(color: ColorName.gray10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.resetEntireForm();
                  Get.toNamed('/invoiceDetail');
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(156, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ColorName.gray11),
                child: Text(
                  'Create Invoice',
                  style: Get.theme.textTheme.titleLarge!
                      .copyWith(color: ColorName.blue1),
                ),
              ),
            ),
            hPad8,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(156, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ColorName.blue4),
                onPressed: () {},
                child: Text(
                  'Pay Now',
                  style: Get.theme.textTheme.titleLarge!
                      .copyWith(color: ColorName.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader(Invoice invoice) {
    return StyledContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Info", style: Get.theme.textTheme.bodySmall),
              Text(
                invoice.invoiceNumber,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: ColorName.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          spacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date",
                style: Get.theme.textTheme.bodySmall,
              ),
              Text(
                invoice.date.toString().substring(0, 10),
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: ColorName.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          spacer,
        ],
      ),
    );
  }

  Widget _buildCustomerDetails(Invoice invoice) {
    return StyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('To', style: Get.theme.textTheme.bodySmall),
          Text(
            invoice.customerName,
            style: Get.theme.textTheme.titleSmall!
                .copyWith(color: ColorName.black),
          ),
          Text(
            invoice.address,
            style: Get.theme.textTheme.titleSmall!
                .copyWith(color: ColorName.black),
          ),
          vPad4,
          Text(invoice.email, style: Get.theme.textTheme.bodySmall),
          Text(invoice.phone, style: Get.theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails(Invoice invoice) {
    final textStyle = Get.theme.textTheme.labelSmall;
    return StyledContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Invoice Details',
                style: Get.theme.textTheme.bodySmall,
              ),
              InkWell(
                onTap: () {
                  controller.loadInvoiceData;
                  Get.toNamed('/itemDetail');
                },
                child: Assets.svgs.iconEdit.svg(),
              ),
            ],
          ),
          vPad12,
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2), // Description
              1: FlexColumnWidth(1), // Rate
              2: FlexColumnWidth(1), // Qty
              3: FlexColumnWidth(1), // Tax
              4: FlexColumnWidth(1), // Subtotal
            },
            children: [
              TableRow(
                children: [
                  Text("DESCRIPTION", style: textStyle),
                  Text("RATE", style: textStyle),
                  Text("QTY", style: textStyle),
                  Text("TAX", style: textStyle),
                  Text("SUBTOTAL", style: textStyle),
                ],
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: invoice.items.length,
            itemBuilder: (context, index) {
              final blackText = Get.theme.textTheme.bodySmall!
                  .copyWith(color: ColorName.black);
              final item = invoice.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2), // Description
                    1: FlexColumnWidth(1), // Rate
                    2: FlexColumnWidth(1), // Qty
                    3: FlexColumnWidth(1), // Tax
                    4: FlexColumnWidth(1), // Subtotal
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "${item.description} ${item.category} ${item.item}",
                          style: blackText,
                        ),
                        Text(
                          "\$${item.rate.toStringAsFixed(2)}",
                          style: blackText,
                        ),
                        Text(
                          item.quantity.toStringAsFixed(2),
                          style: blackText,
                        ),
                        Text(
                          item.tax,
                          style: blackText,
                        ),
                        Text(
                          "\$${item.subtotal.toStringAsFixed(2)}",
                          style: blackText,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotalDetails(Invoice invoice) {
    final textStyle = Get.theme.textTheme.labelSmall!
        .copyWith(color: ColorName.gray6);
    return StyledContainer(
      child: Stack(
        children: [
          // Add the CustomPaint widget for drawing the half circles
          Positioned.fill(
            child: CustomPaint(
              painter: HalfCirclesPainter(),
            ),
          ),
          // Content of the container
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTotalRow(
                label: Text(
                  "Subtotal",
                  style: textStyle,
                ),
                value: "\$${invoice.subtotal.toStringAsFixed(2)}",
              ),
              _buildTotalRow(
                label: Row(
                  children: [
                    Text(
                      "Discount",
                      style: textStyle,
                    ),
                    hPad8,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: ColorName.blue12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${invoice.discountInPercent}%",
                        style: const TextStyle(
                            color: ColorName.blue4, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                value: "${invoice.discount}%",
              ),
              _buildTotalRow(
                label: Text(
                  "Deposit",
                  style: textStyle,
                ),
                value: "\$${invoice.deposit.toStringAsFixed(2)}",
              ),
              _buildTotalRow(
                label: Text(
                  "Paid Invoice",
                  style: textStyle,
                ),
                value: "\$${invoice.paid.toStringAsFixed(2)}",
              ),
              vPad8,
              const Divider(thickness: 1),
              _buildTotalRow(
                label: Text(
                  "GRAND TOTAL",
                  style: Get.theme.textTheme.bodySmall!
                      .copyWith(color: ColorName.black),
                ),
                value: "\$${invoice.grandTotal.toStringAsFixed(2)}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow({required Widget label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label,
        Text(
          value,
          style:
              Get.theme.textTheme.bodySmall!.copyWith(color: ColorName.black),
        ),
      ],
    );
  }
}
