import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_invoice_controller.dart';

class NewInvoiceScreen extends GetView<NewInvoiceController> {
  const NewInvoiceScreen({super.key});

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
                  controller.appBarTitle.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorName.black,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdownField('Category', 'Select One',
                  controller.categories, controller.selectedCategory),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: buildDropdownField('Item', 'Select Item',
                          controller.items, controller.selectedItem)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildDropdownField('', 'Select Truck',
                          controller.trucks, controller.selectedTruck)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          'Rate/Unit', '0.00', controller.ratePerUnit)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildDropdownField('', 'Select Unit',
                          controller.units, controller.selectedUnit)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: buildDropdownField(
                          'Qty', 'Select', controller.units, controller.qty)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: buildDropdownField(
                          'Tax', 'Select', controller.taxes, controller.tax)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: buildTextField(
                          'Total Amount', '0.00', controller.totalAmount,
                          enabled: false)),
                  hPad16,
                  IconButton(
                    style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: ColorName.red12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    icon: Assets.svgs.iconTrash.svg(width: 20),
                    onPressed: () {
                      controller.resetForm();
                    },
                  ),
                ],
              ),
              vPad12,
              Stack(
                children: [
                  const Divider(
                    height: 25,
                    color: ColorName.gray10,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 70,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorName.gray10,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add, size: 15, color: ColorName.black),
                            Text(
                              'Add Item',
                              style: TextStyle(
                                  fontSize: 11, color: ColorName.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              vPad32,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 40,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      backgroundColor: ColorName.blue12),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: ColorName.blue1, fontSize: 17),
                  ),
                ),
              ),
              hPad8,
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      backgroundColor: ColorName.blue4),
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, String hintText, List<String> items,
      RxString selectedValue) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: ColorName.gray1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: ColorName.gray8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
            ),
            icon: const Icon(
              CupertinoIcons.chevron_down,
              size: 17,
              color: ColorName.blue1,
            ),
            style: const TextStyle(
              fontSize: 13,
              color: ColorName.black,
            ),
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            onChanged: (newValue) {
              selectedValue.value = newValue!;
            },
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, String hintText, RxString value,
      {bool enabled = true}) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: ColorName.gray1, fontSize: 12),
          ),
          vPad8,
          TextFormField(
            style: const TextStyle(fontSize: 13),
            enabled: enabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              prefixIcon: const Icon(
                CupertinoIcons.money_dollar,
                color: ColorName.blue1,
                size: 20,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14, color: ColorName.gray8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
            ),
            onChanged: (newValue) {
              value.value = newValue;
            },
            initialValue: value.value,
          ),
        ],
      ),
    );
  }
}
