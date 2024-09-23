import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/widgets/invoice_widgets/dropDownField.dart';
import 'package:crew_app/widgets/invoice_widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../gen/assets.gen.dart';
import 'invoice_controller.dart';

class InvoiceDetailScreen extends GetView<InvoiceController> {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80),
        child: Container(
          margin: const EdgeInsets.only(top: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorName.gray11,
              ),
            ),
          ),
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
                child: Obx(
                  () => Text(
                    controller.invoice.value.invoiceNumber,
                    style: Get.theme.textTheme.titleSmall!.copyWith(
                      color: ColorName.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vPad20,
                // Render each item in the formItems list
                ...controller.formItems.map((index) {
                  return buildFormItem(index);
                }),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.only(top: 22, left: 20, right: 20, bottom: 24),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorName.gray10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(156, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ColorName.blue12),
                child: Text(
                  'Cancel',
                  style: Get.theme.textTheme.titleMedium!
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorName.blue4),
                onPressed: () {
                  // Save the changes
                  controller.saveFormAndNavigate();
                },
                child: Text(
                  'Save',
                  style: Get.theme.textTheme.titleMedium!
                      .copyWith(color: ColorName.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds a single item form widget
  Widget buildFormItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownField(
            label1: '*',
            label: 'Category',
            hintText: 'Select One',
            items: controller.categories,
            selectedValue: controller.selectedCategoryList[index]),
        vPad16,
        Row(
          children: [
            Expanded(
              child: DropDownField(
                  label1: '*',
                  label: 'Item',
                  hintText: 'Select Item',
                  items: controller.items,
                  selectedValue: controller.selectedItemList[index]),
            ),
            hPad16,
            Expanded(
              child: DropDownField(
                  label1: '',
                  label: '',
                  hintText: 'Select Truck',
                  items: controller.trucks,
                  selectedValue: controller.selectedTruckList[index]),
            ),
          ],
        ),
        vPad16,
        Row(
          children: [
            Expanded(
              child: MyTextField(
                textType: const TextInputType.numberWithOptions(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                hintText: '0.00',
                label1: '*',
                icon: CupertinoIcons.money_dollar,
                controllerValue: controller.ratePerUnitList[index],
                label: 'Rate/Unit',
                enabled: true,
              ),
            ),
            hPad16,
            Expanded(
              child: DropDownField(
                  label1: '',
                  label: '',
                  hintText: 'Select Unit',
                  items: controller.units,
                  selectedValue: controller.selectedUnitList[index]),
            ),
          ],
        ),
        vPad16,
        Row(
          children: [
            Expanded(
              child: DropDownField(
                  label1: '*',
                  label: 'Qty',
                  hintText: 'Select',
                  items: controller.qty,
                  selectedValue: controller.qtyList[index]),
            ),
            hPad16,
            Expanded(
              child: DropDownField(
                  label1: '*',
                  label: 'Tax',
                  hintText: 'Select',
                  items: controller.taxes,
                  selectedValue: controller.taxList[index]),
            ),
          ],
        ),
        vPad16,
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: MyTextField(
                textType: const TextInputType.numberWithOptions(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                label: 'Total Amount',
                label1: '*',
                icon: CupertinoIcons.money_dollar,
                hintText: '0.00',
                controllerValue: controller.totalAmountList[index],
                enabled: true,
              ),
            ),
          ],
        ),
        vPad16,
        MyTextField(
          label1: '',
          maxLine: 4,
          label: 'Description',
          hintText: 'Enter Description',
          controllerValue: controller.descriptionList[index],
          enabled: true,
        ),
        vPad16,
      ],
    );
  }
}
