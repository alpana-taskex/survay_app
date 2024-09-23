class ProfileUser {
  String? name;
  String? email;
  String? phone;
  String? employmentType;
  String? department;
  String? abnNumber;
  String? tfnNumber;
  bool? isGstRegistered;
  String? profileAvatarSrc;

  ProfileUser(
      {this.name,
        this.email,
        this.phone,
        this.employmentType,
        this.department,
        this.abnNumber,
        this.tfnNumber,
        this.isGstRegistered,
        this.profileAvatarSrc});

  ProfileUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    employmentType = json['employmentType'];
    department = json['department'];
    abnNumber = json['abnNumber'];
    tfnNumber = json['tfnNumber'];
    isGstRegistered = json['isGstRegistered'];
    profileAvatarSrc = json['profileAvatarSrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['employmentType'] = employmentType;
    data['department'] = department;
    data['abnNumber'] = abnNumber;
    data['tfnNumber'] = tfnNumber;
    data['isGstRegistered'] = isGstRegistered;
    data['profileAvatarSrc'] = profileAvatarSrc;
    return data;
  }
}
