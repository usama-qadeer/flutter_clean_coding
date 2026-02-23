class AuthModel {
  int? id;
  String? branchId;
  dynamic branchName;
  String? image;
  String? username;
  String? email;
  String? number;
  String? role;
  String? termsConditions;
  String? name;
  String? cnic;
  String? dob;
  String? gender;
  String? organisationType;
  String? organisationId;
  String? userClass;
  String? hobbies;
  String? sportsPlayed;
  String? guardianName;
  String? guardianEmail;
  String? guardianNumber;
  String? guardianCnic;
  String? country;
  String? stateProvince;
  String? city;
  String? createdAt;
  String? updatedAt;
  dynamic cnicName;
  dynamic otp;
  dynamic otpExpiresAt;
  String? isVerified;
  bool? profileUpdatedForFatherFit;
  bool? isAgeChanged;
  bool? assessment;
  bool? goalSetting;
  String? profileStep;
  String? token;
  String? countryName;
  String? stateProvinceName;
  String? cityName;
  String? organisationName;
  String? organisationTypeName;

  AuthModel({
    this.id,
    this.branchId,
    this.branchName,
    this.image,
    this.username,
    this.email,
    this.number,
    this.role,
    this.termsConditions,
    this.name,
    this.cnic,
    this.dob,
    this.gender,
    this.organisationType,
    this.organisationId,
    this.userClass,
    this.hobbies,
    this.sportsPlayed,
    this.guardianName,
    this.guardianEmail,
    this.guardianNumber,
    this.guardianCnic,
    this.country,
    this.stateProvince,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.cnicName,
    this.otp,
    this.otpExpiresAt,
    this.isVerified,
    this.profileUpdatedForFatherFit,
    this.isAgeChanged,
    this.assessment,
    this.goalSetting,
    this.profileStep,
    this.token,
    this.countryName,
    this.stateProvinceName,
    this.cityName,
    this.organisationName,
    this.organisationTypeName,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    branchId = json["branch_id"];
    branchName = json["branch_name"];
    image = json["image"];
    username = json["username"];
    email = json["email"];
    number = json["number"];
    role = json["role"];
    termsConditions = json["terms_conditions"];
    name = json["name"];
    cnic = json["cnic"];
    dob = json["dob"];
    gender = json["gender"];
    organisationType = json["organisation_type"];
    organisationId = json["organisation_id"];
    userClass = json["class"];
    hobbies = json["hobbies"];
    sportsPlayed = json["sports_played"];
    guardianName = json["guardian_name"];
    guardianEmail = json["guardian_email"];
    guardianNumber = json["guardian_number"];
    guardianCnic = json["guardian_cnic"];
    country = json["country"];
    stateProvince = json["state_province"];
    city = json["city"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    cnicName = json["cnic_name"];
    otp = json["otp"];
    otpExpiresAt = json["otp_expires_at"];
    isVerified = json["is_verified"];
    profileUpdatedForFatherFit = json["profile_updated_for_father_fit"];
    isAgeChanged = json["is_age_changed"];
    assessment = json["assessment"];
    goalSetting = json["goal_setting"];
    profileStep = json["profile_step"];
    token = json["token"];
    countryName = json["country_name"];
    stateProvinceName = json["state_province_name"];
    cityName = json["city_name"];
    organisationName = json["organisation_name"];
    organisationTypeName = json["organisation_type_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["branch_id"] = branchId;
    data["branch_name"] = branchName;
    data["image"] = image;
    data["username"] = username;
    data["email"] = email;
    data["number"] = number;
    data["role"] = role;
    data["terms_conditions"] = termsConditions;
    data["name"] = name;
    data["cnic"] = cnic;
    data["dob"] = dob;
    data["gender"] = gender;
    data["organisation_type"] = organisationType;
    data["organisation_id"] = organisationId;
    data["class"] = userClass;
    data["hobbies"] = hobbies;
    data["sports_played"] = sportsPlayed;
    data["guardian_name"] = guardianName;
    data["guardian_email"] = guardianEmail;
    data["guardian_number"] = guardianNumber;
    data["guardian_cnic"] = guardianCnic;
    data["country"] = country;
    data["state_province"] = stateProvince;
    data["city"] = city;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["cnic_name"] = cnicName;
    data["otp"] = otp;
    data["otp_expires_at"] = otpExpiresAt;
    data["is_verified"] = isVerified;
    data["profile_updated_for_father_fit"] = profileUpdatedForFatherFit;
    data["is_age_changed"] = isAgeChanged;
    data["assessment"] = assessment;
    data["goal_setting"] = goalSetting;
    data["profile_step"] = profileStep;
    data["token"] = token;
    data["country_name"] = countryName;
    data["state_province_name"] = stateProvinceName;
    data["city_name"] = cityName;
    data["organisation_name"] = organisationName;
    data["organisation_type_name"] = organisationTypeName;
    return data;
  }
}
