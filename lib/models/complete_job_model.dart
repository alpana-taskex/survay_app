class CompleteJob {
  String? sId;
  String? type;
  String? jobTypeId;
  String? orderId;
  String? moveDate;
  String? firstName;
  String? lastName;
  int totalTrucks = 0;
  int totalMen = 0;
  String? customerName;
  String? customerEmail;
  String? mobilePhone;
  List<String>? extraemails;
  List<String>? extraphones;
  String? timing;
  List<JobType>? jobtypes;
  String? source;
  String? sourceId;
  String? movesize;
  String? funishedType;
  PickUpExtra? pickupextra;
  PickUpExtra? dropoffextra;
  List<Inventory>? inventory;
  String? createdAt;
  String? signatureImage;
  List<Employee>? employees;
  List<Truck>? trucks;
  bool? hasAssignedTeam;
  List<String>? teams;
  String? jobStartTime;
  String? jobEndTime;
  List<Estimate>? estimate;
  List<Address>? pickupFullAddress;
  List<Address>? dropoffFullAddress;
  String? status;
  String? pickupAddress;
  Coordinates? pickupAddressCoordinates;
  String? pickupAddressSuburb;
  String? dropoffAddress;
  Coordinates? dropoffAddressCoordinates;
  String? dropoffAddressSuburb;
  String? bookingNotes;

  CompleteJob(
      {this.sId,
        this.type,
        this.jobTypeId,
        this.orderId,
        this.moveDate,
        this.firstName,
        this.lastName,
        this.customerName,
        this.customerEmail,
        this.mobilePhone,
        this.extraemails,
        this.extraphones,
        this.timing,
        this.jobtypes,
        this.source,
        this.sourceId,
        this.movesize,
        this.funishedType,
        this.pickupextra,
        this.dropoffextra,
        this.inventory,
        this.createdAt,
        this.signatureImage,
        this.employees,
        this.trucks,
        this.hasAssignedTeam,
        this.teams,
        this.jobStartTime,
        this.jobEndTime,
        this.estimate,
        this.pickupFullAddress,
        this.dropoffFullAddress,
        this.status,
        this.pickupAddress,
        this.pickupAddressCoordinates,
        this.pickupAddressSuburb,
        this.dropoffAddress,
        this.dropoffAddressCoordinates,
        this.bookingNotes,
        this.dropoffAddressSuburb});

  CompleteJob.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    jobTypeId = json['jobTypeId'];
    orderId = json['order_id'];
    moveDate = json['MoveDate'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    customerName = json['CustomerName'];
    bookingNotes = json['BookingNotes'];
    customerEmail = json['CustomerEmail'];
    mobilePhone = json['MobilePhone'];
    extraemails = json['extraemails'] != null
        ? List<String>.from(json['extraemails'])
        : null;
    extraphones = json['extraphones'] != null
        ? List<String>.from(json['extraphones'])
        : null;
    timing = json['Timing'];
    if (json['jobtypes'] != null) {
      jobtypes = <JobType>[];
      json['jobtypes'].forEach((v) {
        jobtypes!.add(JobType.fromJson(v));
      });
    }
    source = json['Source'];
    sourceId = json['sourceId'];
    movesize = json['movesize'];
    funishedType = json['FunishedType'];
    pickupextra = json['pickupextra'] != null
        ? PickUpExtra.fromJson(json['pickupextra'])
        : null;
    dropoffextra = json['dropoffextra'] != null
        ? PickUpExtra.fromJson(json['dropoffextra'])
        : null;
    if (json['Inventory'] != null) {
      inventory = <Inventory>[];
      json['Inventory'].forEach((v) {
        inventory!.add(Inventory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    signatureImage = json['signatureImage'];
    if (json['employees'] != null) {
      employees = <Employee>[];
      json['employees'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
    if (json['trucks'] != null) {
      trucks = <Truck>[];
      json['trucks'].forEach((v) {
        trucks!.add(Truck.fromJson(v));
      });
    }
    hasAssignedTeam = json['hasAssignedTeam'];
    teams = json['teams'] != null
        ? List<String>.from(json['teams'])
        : null;
    jobStartTime = json['job_start_time'];
    jobEndTime = json['job_end_time'];
    if (json['estimate'] != null) {
      estimate = <Estimate>[];
      json['estimate'].forEach((v) {
        if(v['men'].isNotEmpty){
          int men = int.parse(v['men'].split(' ')[0]);
          totalMen += men;
        }

        // Check if the truck field is not empty
        if (v['truck'].isNotEmpty) {
          totalTrucks += 1;
        }
        estimate!.add(Estimate.fromJson(v));
      });
    }
    if (json['pickupFullAddress'] != null) {
      pickupFullAddress = <Address>[];
      json['pickupFullAddress'].forEach((v) {
        pickupFullAddress!.add(Address.fromJson(v));
      });
    }
    if (json['dropoffFullAddress'] != null) {
      dropoffFullAddress = <Address>[];
      json['dropoffFullAddress'].forEach((v) {
        dropoffFullAddress!.add(Address.fromJson(v));
      });
    }
    status = json['status'];
    pickupAddress = json['pickupAddress'];
    pickupAddressCoordinates = json['pickupAddressCoordinates'] != null
        ? Coordinates.fromJson(json['pickupAddressCoordinates'])
        : null;
    pickupAddressSuburb = json['pickupAddressSuburb'];
    dropoffAddress = json['dropoffAddress'];
    dropoffAddressCoordinates = json['dropoffAddressCoordinates'] != null
        ? Coordinates.fromJson(json['dropoffAddressCoordinates'])
        : null;
    dropoffAddressSuburb = json['dropoffAddressSuburb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['jobTypeId'] = jobTypeId;
    data['order_id'] = orderId;
    data['MoveDate'] = moveDate;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['CustomerName'] = customerName;
    data['CustomerEmail'] = customerEmail;
    data['MobilePhone'] = mobilePhone;
    data['extraemails'] = extraemails;
    data['extraphones'] = extraphones;
    data['BookingNotes'] = bookingNotes;
    data['Timing'] = timing;
    if (jobtypes != null) {
      data['jobtypes'] = jobtypes!.map((v) => v.toJson()).toList();
    }
    data['Source'] = source;
    data['sourceId'] = sourceId;
    data['movesize'] = movesize;
    data['FunishedType'] = funishedType;
    if (pickupextra != null) {
      data['pickupextra'] = pickupextra!.toJson();
    }
    if (dropoffextra != null) {
      data['dropoffextra'] = dropoffextra!.toJson();
    }
    if (inventory != null) {
      data['Inventory'] = inventory!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['signatureImage'] = signatureImage;
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    if (trucks != null) {
      data['trucks'] = trucks!.map((v) => v.toJson()).toList();
    }
    data['hasAssignedTeam'] = hasAssignedTeam;
    data['teams'] = teams;
    data['job_start_time'] = jobStartTime;
    data['job_end_time'] = jobEndTime;
    if (estimate != null) {
      data['estimate'] = estimate!.map((v) => v.toJson()).toList();
    }
    if (pickupFullAddress != null) {
      data['pickupFullAddress'] =
          pickupFullAddress!.map((v) => v.toJson()).toList();
    }
    if (dropoffFullAddress != null) {
      data['dropoffFullAddress'] =
          dropoffFullAddress!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['pickupAddress'] = pickupAddress;
    if (pickupAddressCoordinates != null) {
      data['pickupAddressCoordinates'] =
          pickupAddressCoordinates!.toJson();
    }
    data['pickupAddressSuburb'] = pickupAddressSuburb;
    data['dropoffAddress'] = dropoffAddress;
    if (dropoffAddressCoordinates != null) {
      data['dropoffAddressCoordinates'] =
          dropoffAddressCoordinates!.toJson();
    }
    data['dropoffAddressSuburb'] = dropoffAddressSuburb;
    return data;
  }
}

class JobType {
  String? date;
  String? preferredTimeSlot;
  String? value;
  String? label;
  String? category;
  String? pricetype;
  String? sId;

  JobType(
      {this.date,
        this.preferredTimeSlot,
        this.value,
        this.label,
        this.category,
        this.pricetype,
        this.sId});

  JobType.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    preferredTimeSlot = json['PreferredTimeSlot'];
    value = json['value'];
    label = json['label'];
    category = json['category'];
    pricetype = json['pricetype'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['PreferredTimeSlot'] = preferredTimeSlot;
    data['value'] = value;
    data['label'] = label;
    data['category'] = category;
    data['pricetype'] = pricetype;
    data['_id'] = sId;
    return data;
  }
}

class PickUpExtra {
  String? flights;
  String? narrowstreet;

  PickUpExtra({this.flights, this.narrowstreet});

  PickUpExtra.fromJson(Map<String, dynamic> json) {
    flights = json['flights'];
    narrowstreet = json['narrowstreet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flights'] = flights;
    data['narrowstreet'] = narrowstreet;
    return data;
  }
}

class Inventory {
  String? itemname;
  String? itemimg;
  String? itemh;
  String? itemw;
  String? itemd;
  String? itemtotalvalue;
  bool? local;
  ItemType? itemType;
  String? sId;

  Inventory(
      {this.itemname,
        this.itemimg,
        this.itemh,
        this.itemw,
        this.itemd,
        this.itemtotalvalue,
        this.local,
        this.itemType,
        this.sId});

  Inventory.fromJson(Map<String, dynamic> json) {
    itemname = json['itemname'];
    itemimg = json['itemimg'];
    itemh = json['itemh'];
    itemw = json['itemw'];
    itemd = json['itemd'];
    itemtotalvalue = json['itemtotalvalue'];
    local = json['local'];
    itemType = json['itemType'] != null
        ? ItemType.fromJson(json['itemType'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemname'] = itemname;
    data['itemimg'] = itemimg;
    data['itemh'] = itemh;
    data['itemw'] = itemw;
    data['itemd'] = itemd;
    data['itemtotalvalue'] = itemtotalvalue;
    data['local'] = local;
    if (itemType != null) {
      data['itemType'] = itemType!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class ItemType {
  int? id;
  bool? master;
  String? name;

  ItemType({this.id, this.master, this.name});

  ItemType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    master = json['master'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['master'] = master;
    data['name'] = name;
    return data;
  }
}

class Employee {
  String? sId;
  String? department;
  String? name;

  Employee({this.sId, this.department, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    department = json['department'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['department'] = department;
    data['name'] = name;
    return data;
  }
}

class Truck {
  String? sId;
  String? vehicleName;
  String? capacityinTons;

  Truck({this.sId, this.vehicleName, this.capacityinTons});

  Truck.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleName = json['vehicleName'];
    capacityinTons = json['capacityinTons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vehicleName'] = vehicleName;
    data['capacityinTons'] = capacityinTons;
    return data;
  }
}

class Estimate {
  String? category;
  String? men;
  String? truck;
  String? unit;
  String? items;
  String? minhours;
  String? description;
  String? tax;
  String? taxlabel;
  num? taxpercentage;
  bool? istaxadded;
  bool? ism3;
  bool? ismanualPricing;
  num? qty;
  num? rate;
  num? totalamount;
  num? basictotalamount;
  DepotDetails? depotdetails;
  String? sId;

  Estimate(
      {this.category,
        this.men,
        this.truck,
        this.unit,
        this.items,
        this.minhours,
        this.description,
        this.tax,
        this.taxlabel,
        this.taxpercentage,
        this.istaxadded,
        this.ism3,
        this.ismanualPricing,
        this.qty,
        this.rate,
        this.totalamount,
        this.basictotalamount,
        this.depotdetails,
        this.sId});

  Estimate.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    men = json['men'];
    truck = json['truck'];
    unit = json['unit'];
    items = json['items'];
    minhours = json['minhours'];
    description = json['description'];
    tax = json['tax'];
    taxlabel = json['taxlabel'];
    taxpercentage = json['taxpercentage'];
    istaxadded = json['istaxadded'];
    ism3 = json['ism3'];
    ismanualPricing = json['ismanualPricing'];
    qty = json['qty'];
    rate = json['rate'];
    totalamount = json['totalamount'];
    basictotalamount = json['basictotalamount'];
    depotdetails = json['depotdetails'] != null
        ? DepotDetails.fromJson(json['depotdetails'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['men'] = men;
    data['truck'] = truck;
    data['unit'] = unit;
    data['items'] = items;
    data['minhours'] = minhours;
    data['description'] = description;
    data['tax'] = tax;
    data['taxlabel'] = taxlabel;
    data['taxpercentage'] = taxpercentage;
    data['istaxadded'] = istaxadded;
    data['ism3'] = ism3;
    data['ismanualPricing'] = ismanualPricing;
    data['qty'] = qty;
    data['rate'] = rate;
    data['totalamount'] = totalamount;
    data['basictotalamount'] = basictotalamount;
    if (depotdetails != null) {
      data['depotdetails'] = depotdetails!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class DepotDetails {
  String? createdAt;

  DepotDetails({this.createdAt});

  DepotDetails.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreatedAt'] = createdAt;
    return data;
  }
}

class WaypointModel {
  String? suburb;
  String? description;
  LatLon? latlng;
  String? locationNotes;
  bool? enabled;
  bool? primaryAddress;
  Null postcode;
  String? state;
  bool? isManualAddress;

  WaypointModel(
      {this.suburb,
        this.description,
        this.latlng,
        this.locationNotes,
        this.enabled,
        this.primaryAddress,
        this.postcode,
        this.state,
        this.isManualAddress});

  WaypointModel.fromJson(Map<String, dynamic> json) {
    suburb = json['suburb'];
    description = json['description'];
    latlng =
    json['latlng'] != null ? LatLon.fromJson(json['latlng']) : null;
    locationNotes = json['LocationNotes'];
    enabled = json['enabled'];
    primaryAddress = json['PrimaryAddress'];
    postcode = json['Postcode'];
    state = json['State'];
    isManualAddress = json['isManualAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suburb'] = suburb;
    data['description'] = description;
    if (latlng != null) {
      data['latlng'] = latlng!.toJson();
    }
    data['LocationNotes'] = locationNotes;
    data['enabled'] = enabled;
    data['PrimaryAddress'] = primaryAddress;
    data['Postcode'] = postcode;
    data['State'] = state;
    data['isManualAddress'] = isManualAddress;
    return data;
  }
}

class LatLon {
  double? lat;
  double? lng;

  LatLon({this.lat, this.lng});

  LatLon.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Address {
  String? address;
  String? suburb;
  bool? primaryAddress;
  Coordinates? coordinates;
  List<WaypointModel> waypoints =[];

  Address(
      {this.address,
        this.suburb,
        this.primaryAddress,
        this.coordinates});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    suburb = json['suburb'];
    primaryAddress = json['PrimaryAddress'];
    coordinates = json['cordinates'] != null
        ? Coordinates.fromJson(json['cordinates'])
        : null;
    if (json['waypoints'] is List) {
      json['waypoints'].forEach((v) {
        waypoints.add(WaypointModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['suburb'] = suburb;
    data['PrimaryAddress'] = primaryAddress;
    if (coordinates != null) {
      data['cordinates'] = coordinates!.toJson();
    }
    data['waypoints'] = waypoints.map((v) => v.toJson()).toList();
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}


