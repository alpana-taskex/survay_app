class PaymentModel {
  String paymentMethod;
  double amount;
  String cardNumber;
  String cardholderName;
  String expiry;
  String cvv;
  String emailAddress;
  String accountName;
  String accountNumber;
  String bsbNumber;

  PaymentModel({
    this.paymentMethod = 'Credit Card',
    this.amount = 0.0,
    this.cardNumber = '',
    this.cardholderName = '',
    this.expiry = '',
    this.cvv = '',
    this.emailAddress = '',
    this.accountName = '',
    this.accountNumber = '',
    this.bsbNumber = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': paymentMethod,
      'amount': amount,
      'cardNumber': cardNumber,
      'cardholderName': cardholderName,
      'expiry': expiry,
      'cvv': cvv,
      'emailAddress': emailAddress,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'bsbNumber': bsbNumber,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentMethod: json['paymentMethod'] ?? 'Credit Card',
      amount: json['amount']?.toDouble() ?? 0.0,
      cardNumber: json['cardNumber'] ?? '',
      cardholderName: json['cardholderName'] ?? '',
      expiry: json['expiry'] ?? '',
      cvv: json['cvv'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      bsbNumber: json['bsbNumber'] ?? '',
    );
  }
}