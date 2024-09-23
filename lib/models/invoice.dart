class InvoiceItem {
  final String description;
  final String category;
  final String item;
  final double rate;
  final double quantity;
  final String tax;
  final double subtotal;


  InvoiceItem({
    required this.description,
    required this.category,
    required this.item,
    required this.rate,
    required this.quantity,
    required this.tax,
    required this.subtotal,
  });
}

class Invoice {
  final String invoiceNumber;
  final DateTime date;
  final String customerName;
  final String address;
  final String email;
  final String phone;
  List<InvoiceItem> items = [];
  double subtotal;
  final double discount;
  final double deposit;
  final double paid;
  final num discountInPercent;

  Invoice({
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.address,
    required this.email,
    required this.phone,
    this.items = const [],
    required this.subtotal,
    required this.discount,
    required this.deposit,
    required this.paid, 
    required  this.discountInPercent,
  });

  double get grandTotal => subtotal - discount;
}


