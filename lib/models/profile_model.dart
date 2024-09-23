class ProfileModel {
  String name;
  String email;
  String phone;
  String employmentType;
  String department;
  String abnNumber;
  String tfnNumber;
  bool isGstRegistered;
  String profileAvatarSrc;

  ProfileModel({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.employmentType = '',
    this.department = '',
    this.abnNumber = '',
    this.tfnNumber = '',
    this.isGstRegistered = false,
    this.profileAvatarSrc = '',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      employmentType: json['employmentType'] ?? '',
      department: json['department'] ?? '',
      abnNumber: json['abnNumber'] ?? '',
      tfnNumber: json['tfnNumber'] ?? '',
      isGstRegistered: json['isGstRegistered'] ?? false,
      profileAvatarSrc: json['profileAvatarSrc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'employmentType': employmentType,
      'department': department,
      'abnNumber': abnNumber,
      'tfnNumber': tfnNumber,
      'isGstRegistered': isGstRegistered,
      'profileAvatarSrc': profileAvatarSrc,
    };
  }
}