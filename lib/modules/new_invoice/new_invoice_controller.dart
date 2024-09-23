import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

class NewInvoiceController extends BaseController {
  var appBarTitle = 'ESTD9180'.obs;
  var selectedCategory = ''.obs;
  var selectedItem = ''.obs;
  var selectedTruck = ''.obs;
  var ratePerUnit = ''.obs;
  var selectedUnit = ''.obs;
  var qty = ''.obs;
  var tax = ''.obs;
  var totalAmount = ''.obs;

  List<String> categories = ['Select One', 'Category 1', 'Category 2'];
  List<String> items = ['Select Item', 'Item 1', 'Item 2'];
  List<String> trucks = ['Select Truck', 'Truck 1', 'Truck 2'];
  List<String> units = ['Select Unit', 'Unit 1', 'Unit 2'];
  List<String> taxes = ['Select', 'Tax 1', 'Tax 2'];

  // Function to calculate the total amount based on rate, qty, and tax
  void calculateTotalAmount() {
    // Implement calculation logic here
    // Update the totalAmount variable
    // This is just an example
    totalAmount.value = '\$100.00';
  }

  // Function to reset form
  void resetForm() {
    selectedCategory.value = '';
    selectedItem.value = '';
    selectedTruck.value = '';
    ratePerUnit.value = '';
    selectedUnit.value = '';
    qty.value = '';
    tax.value = '';
    totalAmount.value = '';
  }
}
