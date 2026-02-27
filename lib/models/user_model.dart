import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';

enum TypeUser { MEDICAL_STAFF, PATIENT }

class UserModel {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final Gender? gender;
  final String imageUrl;
  final String lastName;
  final String middleName;
  final TypeUser typeUser;
  final DateTime updateAt;
  final String countryCode;
  final DateTime createdAt;
  final BloodType? bloodType;
  final String secondLastName;
  final String specialization;
  final DateTime? dateOfBirth;
  final String identificationType;
  final String identityDocumentUrl;
  final String identificationNumber;
  final BiologicalSexType? biologicalSex;
  final String identityDocumentBackUrl;
  final bool isDeleted;
  final bool isActive;
  final bool isRoot;
  
  // Nuevos campos agregados
  final TimeOfDay? timeOfBirth;
  final String? myCountryCode;
  final String? countryOfNationality;
  final String? countryOfNationalityCode;
  final String? countryName;
  final String? departmentCode;
  final String? departmentName;
  final String? cityCode;
  final String? cityName;
  final String? residenceArea;
  final String? healthAdministratorCode;
  final String? healthAdministratorName;
  final String signatureDocumentUrl;
  

  UserModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.typeUser,
    required this.lastName,
    required this.updateAt,
    required this.createdAt,
    required this.countryCode,
    required this.specialization,
    required this.identificationType,
    required this.identityDocumentUrl,
    required this.identityDocumentBackUrl,
    required this.identificationNumber,
    required this.secondLastName,
    required this.middleName,
    this.isDeleted = false,
    this.isActive = true,
    this.isRoot = false,
    this.dateOfBirth,
    this.gender,
    this.biologicalSex,
    this.bloodType,
    this.timeOfBirth,
    this.myCountryCode,
    this.countryOfNationality,
    this.countryOfNationalityCode,
    this.countryName,
    this.departmentCode,
    this.departmentName,
    this.cityCode,
    this.cityName,
    this.residenceArea,
    this.healthAdministratorCode,
    this.healthAdministratorName,
    required this.signatureDocumentUrl,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
    String? lastName,
    DateTime? updateAt,
    TypeUser? typeUser,
    String? countryCode,
    DateTime? createdAt,
    String? specialization,
    String? identityDocumentUrl,
    String? middleName,
    String? secondLastName,
    String? identityDocumentBackUrl,
    String? identificationType,
    String? identificationNumber,
    DateTime? dateOfBirth,
    Gender? gender,
    BiologicalSexType? biologicalSex,
    BloodType? bloodType,
    bool? isDeleted,
    bool? isActive,
    bool? isRoot,
    TimeOfDay? timeOfBirth,
    String? myCountryCode,
    String? countryOfNationality,
    String? countryOfNationalityCode,
    String? countryName,
    String? departmentCode,
    String? departmentName,
    String? cityCode,
    String? cityName,
    String? residenceArea,
    String? healthAdministratorCode,
    String? healthAdministratorName,
    String? signatureDocumentUrl,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    gender: gender ?? this.gender,
    biologicalSex: biologicalSex ?? this.biologicalSex,
    imageUrl: imageUrl ?? this.imageUrl,
    updateAt: updateAt ?? this.updateAt,
    typeUser: typeUser ?? this.typeUser,
    lastName: lastName ?? this.lastName,
    middleName: middleName ?? this.middleName,
    secondLastName: secondLastName ?? this.secondLastName,
    bloodType: bloodType ?? this.bloodType,
    createdAt: createdAt ?? this.createdAt,
    countryCode: countryCode ?? this.countryCode,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    specialization: specialization ?? this.specialization,
    identificationType: identificationType ?? this.identificationType,
    identityDocumentUrl: identityDocumentUrl ?? this.identityDocumentUrl,
    identityDocumentBackUrl:
        identityDocumentBackUrl ?? this.identityDocumentBackUrl,
    identificationNumber: identificationNumber ?? this.identificationNumber,
    isDeleted: isDeleted ?? this.isDeleted,
    isActive: isActive ?? this.isActive,
    isRoot: isRoot ?? this.isRoot,
    timeOfBirth: timeOfBirth ?? this.timeOfBirth,
    myCountryCode: myCountryCode ?? this.myCountryCode,
    countryOfNationality: countryOfNationality ?? this.countryOfNationality,
    countryOfNationalityCode:
        countryOfNationalityCode ?? this.countryOfNationalityCode,
    countryName: countryName ?? this.countryName,
    departmentCode: departmentCode ?? this.departmentCode,
    departmentName: departmentName ?? this.departmentName,
    cityCode: cityCode ?? this.cityCode,
    cityName: cityName ?? this.cityName,
    residenceArea: residenceArea ?? this.residenceArea,
    healthAdministratorCode: healthAdministratorCode ?? this.healthAdministratorCode,
    healthAdministratorName: healthAdministratorName ?? this.healthAdministratorName,
    signatureDocumentUrl: signatureDocumentUrl ?? this.signatureDocumentUrl,
  );

  factory UserModel.fromJson(json) => UserModel(
    id: json["id"],
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    imageUrl: json["image_url"] ?? "",
    lastName: json["last_name"] ?? "",
    countryCode: json["country_code"] ?? "",
    specialization: json["specialization"] ?? "",
    typeUser: _generateTypeUser(json["type_user"]),
    identificationType: json["identification_type"] ?? "",
    identityDocumentUrl: json["identity_document_url"] ?? "",
    identificationNumber: json["identification_number"] ?? "",
    identityDocumentBackUrl: json["identity_document_back_url"] ?? "",
    middleName: json["middle_name"] ?? "",
    secondLastName: json["second_last_name"] ?? "",
    gender: json["gender"] != null ? _generateGender(json["gender"]) : null,
    biologicalSex: json["biological_sex"] != null
        ? _generateBiologicalSexType(json["biological_sex"])
        : null,
    bloodType: json["blood_type"] != null ? bloodTypeFromString(json["blood_type"]) : null,
    updateAt: json["update_at"] != null ? DateTime.parse(json["update_at"]): DateTime.now(),
    dateOfBirth: json["date_of_birth"] != null ? DateTime.parse(json["date_of_birth"]) : null,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    isDeleted: json["is_deleted"] == true,
    isActive: json["is_active"] != false,
    isRoot: json["is_root"] == true,
    timeOfBirth: json["time_of_birth"] != null ? _parseTimeOfDay(json["time_of_birth"]) : null,
    myCountryCode: json["my_country_code"],
    countryOfNationality: json["country_of_nationality"],
    countryOfNationalityCode: json["country_of_nationality_code"],
    countryName: json["country_name"],
    departmentCode: json["department_code"],
    departmentName: json["department_name"],
    cityCode: json["city_code"],
    cityName: json["city_name"],
    residenceArea: json["residence_area"],
    healthAdministratorCode: json["health_administrator_code"],
    healthAdministratorName: json["health_administrator_name"],
    signatureDocumentUrl: json["signature_document_url"] ?? "",
  );

  factory UserModel.init() => UserModel(
    name: "",
    email: "",
    phone: "",
    imageUrl: "",
    lastName: "",
    middleName: "",
    secondLastName: "",
    gender: null,
    biologicalSex: null,
    bloodType: null,
    countryCode: "",
    dateOfBirth: null,
    specialization: "",
    identificationType: "",
    identityDocumentUrl: "",
    updateAt: DateTime.now(),
    identificationNumber: "",
    createdAt: DateTime.now(),
    typeUser: TypeUser.PATIENT,
    identityDocumentBackUrl: "",
    isDeleted: false,
    isActive: true,
    isRoot: false,
    timeOfBirth: null,
    myCountryCode: null,
    countryOfNationality: null,
    countryOfNationalityCode: null,
    countryName: null,
    departmentCode: null,
    departmentName: null,
    cityCode: null,
    cityName: null,
    residenceArea: null,
    healthAdministratorCode: null,
    healthAdministratorName: null,
    signatureDocumentUrl: "",
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
      "is_root": isRoot,
      "image_url": imageUrl,
      "last_name": lastName,
      "is_active": isActive,
      "is_deleted": isDeleted,
      "type_user": typeUser.name,
      "country_code": countryCode,
      "signature_document_url": signatureDocumentUrl,
      "update_at": updateAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "identification_type": identificationType,
      "identity_document_url": identityDocumentUrl,
      "identification_number": identificationNumber,
      "identity_document_back_url": identityDocumentBackUrl,
      "specialization": specialization.isEmpty ? null : specialization,
      "middle_name": middleName,
      "second_last_name": secondLastName,
    };

    if (dateOfBirth != null) {
      data["date_of_birth"] = dateOfBirth!.toIso8601String();
    }
    if (gender != null) {
      data["gender"] = gender!.name;
    }
    if (biologicalSex != null) {
      data["biological_sex"] = biologicalSex!.name;
    }
    if (bloodType != null) {
      data["blood_type"] = bloodType!.value;
    }
    if (timeOfBirth != null) {
      data["time_of_birth"] = _formatTimeOfDay(timeOfBirth!);
    }
    if (myCountryCode != null) {
      data["my_country_code"] = myCountryCode;
    }
    if (countryOfNationality != null) {
      data["country_of_nationality"] = countryOfNationality;
    }
    if (countryOfNationalityCode != null) {
      data["country_of_nationality_code"] = countryOfNationalityCode;
    }
    if (countryName != null) {
      data["country_name"] = countryName;
    }
    if (departmentCode != null) {
      data["department_code"] = departmentCode;
    }
    if (departmentName != null) {
      data["department_name"] = departmentName;
    }
    if (cityCode != null) {
      data["city_code"] = cityCode;
    }
    if (cityName != null) {
      data["city_name"] = cityName;
    }
    if (residenceArea != null) {
      data["residence_area"] = residenceArea;
    }
    if (healthAdministratorCode != null) {
      data["health_administrator_code"] = healthAdministratorCode;
    }
    if (healthAdministratorName != null) {
      data["health_administrator_name"] = healthAdministratorName;
    }
    if (signatureDocumentUrl.isNotEmpty) {
      data["signature_document_url"] = signatureDocumentUrl;
    }

    return data;
  }

  bool compareWith(UserModel other) {
    return id == other.id &&
      name == other.name &&
      phone == other.phone &&
      email == other.email &&
      gender == other.gender &&
      biologicalSex == other.biologicalSex &&
      lastName == other.lastName &&
      typeUser == other.typeUser &&
      middleName == other.middleName &&
      secondLastName == other.secondLastName &&
      bloodType == other.bloodType &&
      countryCode == other.countryCode &&
      specialization == other.specialization &&
      (dateOfBirth == null && other.dateOfBirth == null ||
        dateOfBirth != null && other.dateOfBirth != null &&
        dateOfBirth!.isAtSameMomentAs(other.dateOfBirth!)) &&
      identificationType == other.identificationType &&
      identityDocumentUrl == other.identityDocumentUrl &&
      identityDocumentBackUrl == other.identityDocumentBackUrl &&
      identificationNumber == other.identificationNumber &&
      isDeleted == other.isDeleted &&
      isActive == other.isActive &&
      isRoot == other.isRoot &&
      timeOfBirth == other.timeOfBirth &&
      myCountryCode == other.myCountryCode &&
      countryOfNationality == other.countryOfNationality &&
      countryOfNationalityCode == other.countryOfNationalityCode &&
      countryName == other.countryName &&
      departmentCode == other.departmentCode &&
      departmentName == other.departmentName &&
      cityCode == other.cityCode &&
      cityName == other.cityName &&
      residenceArea == other.residenceArea &&
      healthAdministratorCode == other.healthAdministratorCode &&
      healthAdministratorName == other.healthAdministratorName &&
      signatureDocumentUrl == other.signatureDocumentUrl;
  }
}

TypeUser _generateTypeUser(String? text) {
  if (text == TypeUser.MEDICAL_STAFF.name) {
    return TypeUser.MEDICAL_STAFF;
  }
  if (text == TypeUser.PATIENT.name) {
    return TypeUser.PATIENT;
  } else {
    return TypeUser.MEDICAL_STAFF;
  }
}

Gender _generateGender(String? text) {
  switch (text?.toLowerCase()) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'other':
      return Gender.other;
    default:
      return Gender.other;
  }
}

BiologicalSexType _generateBiologicalSexType(String? text) {
  switch (text?.toLowerCase()) {
    case 'male':
    case 'hombre':
      return BiologicalSexType.male;
    case 'female':
    case 'mujer':
      return BiologicalSexType.female;
    case 'intersex':
    case 'indeterminate':
    case 'indeterminate_or_intersex':
    case 'indeterminateorintersex':
    case 'indeterminado':
    case 'indeterminado o intersexual':
      return BiologicalSexType.indeterminateOrIntersex;
    default:
      return BiologicalSexType.indeterminateOrIntersex;
  }
}

/// Parsea un string en formato "HH:mm" a TimeOfDay
/// Formato esperado: "09:30", "14:45", "23:15"
TimeOfDay? _parseTimeOfDay(String? timeString) {
  if (timeString == null || timeString.isEmpty) return null;
  
  try {
    final parts = timeString.split(':');
    if (parts.length != 2) return null;
    
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    
    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    return null;
  }
}

/// Formatea un TimeOfDay a string en formato "HH:mm"
/// Ejemplo: TimeOfDay(hour: 9, minute: 30) -> "09:30"
String _formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
