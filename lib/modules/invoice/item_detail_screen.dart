import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/frequent_widgets.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import 'invoice_controller.dart';

class ItemDetailScreen extends GetView<InvoiceController> {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () => Get.toNamed('/invoice'),
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
      body: Column(
        children: [
          Obx(
            () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, left: 10),
              shrinkWrap: true,
              itemCount: controller.invoice.value.items.length,
              itemBuilder: (context, index) {
                final item = controller.invoice.value.items[index];
                return ListTile(
                  title: Text(
                    item.category,
                    style: Get.theme.textTheme.titleSmall!.copyWith(
                      color: ColorName.black,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Assets.svgs.iconEdit.svg(width: 15),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          backgroundColor: ColorName.blue12.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to InvoiceDetail screen for editing
                          controller.loadInvoiceData(controller.invoice.value);
                          Get.toNamed('/invoiceDetail',
                              arguments: {'index': index});
                        },
                      ),
                      hPad8,
                      IconButton(
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          backgroundColor: ColorName.red12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Assets.svgs.iconTrash.svg(width: 15),
                        onPressed: () {
                          controller.resetForm(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Stack(
            children: [
              const Divider(
                height: 25,
                color: ColorName.gray10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/invoiceDetail');
                    controller.addItem;
                  },
                  child: Container(
                    width: 80,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: ColorName.blue12,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 15,
                          color: ColorName.blue1,
                        ),
                        Text(
                          'Add Item',
                          style: TextStyle(
                            fontSize: 11,
                            color: ColorName.blue4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
