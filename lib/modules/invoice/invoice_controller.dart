import 'package:crew_app/models/invoice.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class InvoiceController extends BaseController {
  var invoice = Invoice(
    invoiceNumber: "INV#${DateTime.now().millisecondsSinceEpoch}",
    date: DateTime.now(),
    customerName: "Albert Flores",
    address: "456 Adelaide Street, Brisbane, QLD 4000",
    email: "albert.flores@gmail.com",
    phone: "+61 456 890 190",
    items: [],
    subtotal: 0.0,
    discount: 0.0,
    discountInPercent: 0,
    deposit: 0.0,
    paid: 0.0,
  ).obs;

  var invoices = <Invoice>[].obs;

  // Reactive lists for dynamic form fields
  var selectedCategoryList = <RxString>[].obs;
  var selectedItemList = <RxString>[].obs;
  var selectedTruckList = <RxString>[].obs;
  var ratePerUnitList = <RxString>[].obs;
  var selectedUnitList = <RxString>[].obs;
  var qtyList = <RxString>[].obs;
  var taxList = <RxString>[].obs;
  var totalAmountList = <RxString>[].obs;
  var descriptionList = <RxString>[].obs;
  RxList<int> formItems = <int>[].obs;

  List<String> categories = [
    'Moving Charges',
    'Stair Charges',
    'Labour Charges',
    'Heavy Lift',
    'Packing Charges',
    'Unpacking Charges',
    'Packing Material',
    'Callout Charges',
    'Delivery Charges',
    'Storage Charges',
    'Deposit Charges',
  ];
  List<String> items = List.generate(10, (index) => '${index + 1}');
  List<String> trucks = List.generate(10, (index) => '${index + 1}');
  List<String> units = ['Unit-fixed', 'hour1', 'per unit', 'm3'];
  List<String> qty = List.generate(10, (index) => '${index + 1}');
  List<String> taxes = ['NA', 'GST', 'ITR'];

  var isEditing = false.obs;

  InvoiceController() {
    initializeForm();
  }

  void initializeForm() {
    addItem();
  }

  void calculateTotalAmount() {
    double total =
        invoice.value.items.fold(0, (sum, item) => sum + item.subtotal);
    totalAmountList[0].value = total.toStringAsFixed(2);
  }

  void resetForm(int index) {
    if (index < 0 || index >= formItems.length) return; // Check index validity
    formItems.removeAt(index);
    selectedCategoryList.removeAt(index);
    selectedItemList.removeAt(index);
    selectedTruckList.removeAt(index);
    ratePerUnitList.removeAt(index);
    selectedUnitList.removeAt(index);
    qtyList.removeAt(index);
    taxList.removeAt(index);
    totalAmountList.removeAt(index);
    descriptionList.removeAt(index);
    formItems.value = List.generate(formItems.length, (i) => i);
  }

  void resetEntireForm() {
    formItems.clear();
    selectedCategoryList.clear();
    selectedItemList.clear();
    selectedTruckList.clear();
    ratePerUnitList.clear();
    selectedUnitList.clear();
    qtyList.clear();
    taxList.clear();
    totalAmountList.clear();
    descriptionList.clear();
    addItem(); // Optionally add a fresh form item if needed
  }

  void loadInvoiceData(Invoice invoiceData) {
    invoice.value = invoiceData;
    isEditing.value = true;
    formItems.clear();

    for (int i = 0; i < invoiceData.items.length; i++) {
      addItem();
      selectedCategoryList[i].value = invoiceData.items[i].category;
      selectedItemList[i].value = invoiceData.items[i].item;
      selectedTruckList[i].value = '';
      ratePerUnitList[i].value = invoiceData.items[i].rate.toString();
      selectedUnitList[i].value = '';
      qtyList[i].value = invoiceData.items[i].quantity.toString();
      taxList[i].value = invoiceData.items[i].tax;
      totalAmountList[i].value =
          invoiceData.items[i].subtotal.toStringAsFixed(2);
      descriptionList[i].value = invoiceData.items[i].description;
    }
  }

  void updateInvoiceItem(int index, InvoiceItem newItem) {
    if (index < 0 || index >= invoice.value.items.length) return;

    invoice.update((val) {
      val?.items[index] = newItem;
      val?.subtotal = val.items.fold(0, (sum, item) => sum + item.subtotal);
    });
  }

  void addInvoiceItem(InvoiceItem newItem) {
    invoice.update((val) {
      val?.items.add(newItem);
      val?.subtotal += newItem.subtotal;
    });
    calculateTotalAmount();
  }

  void saveInvoice() {
    if (isEditing.value) {
      int index = invoices.indexWhere(
          (inv) => inv.invoiceNumber == invoice.value.invoiceNumber);
      if (index != -1) invoices[index] = invoice.value;
    } else {
      invoices.add(invoice.value);
    }
    isEditing.value = false;
  }

  void addItem() {
    int newIndex = formItems.length;
    formItems.add(newIndex);
    selectedCategoryList.add(''.obs);
    selectedItemList.add(''.obs);
    selectedTruckList.add(''.obs);
    ratePerUnitList.add(''.obs);
    selectedUnitList.add(''.obs);
    qtyList.add(''.obs);
    taxList.add(''.obs);
    totalAmountList.add(''.obs);
    descriptionList.add(''.obs);
  }

  void saveFormAndNavigate() {
    List<InvoiceItem> items = [];
    for (int i = 0; i < formItems.length; i++) {
      items.add(InvoiceItem(
        description: descriptionList[i].value,
        item: selectedItemList[i].value,
        category: selectedCategoryList[i].value,
        rate: double.tryParse(ratePerUnitList[i].value) ?? 0,
        quantity: double.tryParse(qtyList[i].value) ?? 0,
        tax: taxList[i].value,
        subtotal: double.tryParse(totalAmountList[i].value) ?? 0,
      ));
    }

    invoice.update((val) {
      val?.items = items;
      val?.subtotal = items.fold(0, (sum, item) => sum + item.subtotal);
    });

    saveInvoice();
    Get.back();
  }
}
