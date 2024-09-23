import 'package:logger/logger.dart';

class WalletModel {
  List<WalletJob> completedJobs = [];
  Wallet? wallet;

  WalletModel({this.wallet});

  WalletModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data']['docs'] != null) {
      completedJobs = (json['data']['docs'] as List)
          .map((i) => WalletJob.fromJson(i))
          .toList();
    }
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    Logger().i("Parsed WalletModel: Jobs count: ${completedJobs.length}, Wallet: $wallet");
  }
}

class WalletJob {
  String? sId;
  Employee? employee;
  String? type;
  num? extra;
  num? empextra;
  num? heavyliftprice;
  num? totalFlights;
  num? jobTime;
  num? workPrice;
  String? createdAt;
  String? expenseId;
  JobDetails? job;

  WalletJob({
    this.sId,
    this.employee,
    this.type,
    this.extra,
    this.empextra,
    this.heavyliftprice,
    this.totalFlights,
    this.jobTime,
    this.workPrice,
    this.createdAt,
    this.expenseId,
    this.job,
  });

  WalletJob.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    type = json['type'];
    extra = json['extra'];
    empextra = json['empextra'];
    heavyliftprice = json['heavyliftprice'];
    totalFlights = json['TotalFlights'];
    jobTime = json['JobTime'];
    workPrice = json['WorkPrice'];
    createdAt = json['createdAt'];
    expenseId = json['expenseId'];
    job = json['job'] != null ? JobDetails.fromJson(json['job']) : null;
  }
}

class Employee {
  String? sId;
  String? employeeID;
  String? name;
  Map<String, String>? days;

  Employee({this.sId, this.employeeID, this.name, this.days});

  Employee.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employeeID = json['employeeID'];
    name = json['name'];
    days = json['days'] != null ? Map<String, String>.from(json['days']) : null;
  }
}

class JobDetails {
  String? sId;
  String? orderId;
  String? moveDate;
  String? customerName;
  String? customerEmail;
  String? mobilePhone;
  List<String> extraemails = [];
  List<String> extraphones = [];

  JobDetails({
    this.sId,
    this.orderId,
    this.moveDate,
    this.customerName,
    this.customerEmail,
    this.mobilePhone,
  });

  JobDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    moveDate = json['MoveDate'];
    customerName = json['CustomerName'];
    customerEmail = json['CustomerEmail'];
    mobilePhone = json['MobilePhone'];
    extraemails = List<String>.from(json['extraemails'] ?? []);
    extraphones = List<String>.from(json['extraphones'] ?? []);
  }
}

class Wallet {
  num? iId;
  num? totalJobsCompleted;
  num? totalHours;
  num? totalEarnings;

  Wallet({
    this.iId,
    this.totalJobsCompleted,
    this.totalHours,
    this.totalEarnings,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    totalJobsCompleted = json['totalJobsCompleted'];
    totalHours = json['totalHours'];
    totalEarnings = json['totalEarnings'];
  }

  @override
  String toString() {
    return 'Wallet(iId: $iId, totalJobsCompleted: $totalJobsCompleted, totalHours: $totalHours, totalEarnings: $totalEarnings)';
  }
}