class Survey {
  String? sId;
  String? type;
  String? orderId;
  String? moveDate;
  String? customerName;
  String? customerEmail;
  String? mobilePhone;
  String? timing;
  String? status;
  String? pickupAddress;
  Coordinates? pickupAddressCoordinates;
  String? dropoffAddress;
  Coordinates? dropoffAddressCoordinates;
  String? bookingNotes;

  Survey({
    this.sId,
    this.type,
    this.orderId,
    this.moveDate,
    this.customerName,
    this.customerEmail,
    this.mobilePhone,
    this.timing,
    this.status,
    this.pickupAddress,
    this.pickupAddressCoordinates,
    this.dropoffAddress,
    this.dropoffAddressCoordinates,
    this.bookingNotes,
  });

  Survey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    orderId = json['order_id'];
    moveDate = json['MoveDate'];
    customerName = json['CustomerName'];
    customerEmail = json['CustomerEmail'];
    mobilePhone = json['MobilePhone'];
    timing = json['Timing'];
    status = json['status'];
    pickupAddress = json['pickupAddress'];
    pickupAddressCoordinates = json['pickupAddressCoordinates'] != null
        ? Coordinates.fromJson(json['pickupAddressCoordinates'])
        : null;
    dropoffAddress = json['dropoffAddress'];
    dropoffAddressCoordinates = json['dropoffAddressCoordinates'] != null
        ? Coordinates.fromJson(json['dropoffAddressCoordinates'])
        : null;
    bookingNotes = json['BookingNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['order_id'] = orderId;
    data['MoveDate'] = moveDate;
    data['CustomerName'] = customerName;
    data['CustomerEmail'] = customerEmail;
    data['MobilePhone'] = mobilePhone;
    data['Timing'] = timing;
    data['status'] = status;
    data['pickupAddress'] = pickupAddress;
    if (pickupAddressCoordinates != null) {
      data['pickupAddressCoordinates'] = pickupAddressCoordinates!.toJson();
    }
    data['dropoffAddress'] = dropoffAddress;
    if (dropoffAddressCoordinates != null) {
      data['dropoffAddressCoordinates'] = dropoffAddressCoordinates!.toJson();
    }
    data['BookingNotes'] = bookingNotes;
    return data;
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
