import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';

enum TypeUser { MEDICAL_STAFF, PATIENT }

class UserModel {
  final String? id;
  final String name;
  final bool isRoot;
  final String phone;
  final String email;
  final bool isActive;
  final Gender? gender;
  final bool isDeleted;
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
  final String identityDocumentBackUrl;
  final BiologicalSexType? biologicalSex;

  // Nuevos campos agregados
  final String? cityCode;
  final String? cityName;
  final String? countryName;
  final String? myCountryCode;
  final String? residenceArea;
  final TimeOfDay? timeOfBirth;
  final String? departmentName;
  final String? departmentCode;
  final String signatureDocumentUrl;
  final String? countryOfNationality;
  final String? countryOfNationalityCode;
  final String healthAdministratorId;
  final String healthAdministratorName;
  final String healthAdministratorCode;
  final GenderIdentity? genderIdentity;
  final DisabilityCategory? disabilityCategory;
  final EthnicityType? ethnicity;
  final String? ethnicCommunity;
  final String userType;
  final String residenceAreaCode;

  UserModel({
    this.id,
    this.gender,
    this.cityCode,
    this.cityName,
    this.bloodType,
    this.timeOfBirth,
    this.countryName,
    this.dateOfBirth,
    this.myCountryCode,
    this.biologicalSex,
    this.residenceArea,
    required this.name,
    this.departmentCode,
    this.departmentName,
    required this.phone,
    required this.email,
    this.isRoot = false,
    this.isActive = true,
    required this.imageUrl,
    required this.typeUser,
    required this.lastName,
    required this.updateAt,
    this.isDeleted = false,
    required this.createdAt,
    required this.middleName,
    this.countryOfNationality,
    required this.countryCode,
    this.healthAdministratorId = "",
    this.healthAdministratorName = "",
    this.healthAdministratorCode = "",
    required this.secondLastName,
    required this.specialization,
    this.countryOfNationalityCode,
    required this.identificationType,
    required this.identityDocumentUrl,
    required this.identificationNumber,
    required this.signatureDocumentUrl,
    required this.identityDocumentBackUrl,
    this.genderIdentity,
    this.disabilityCategory,
    this.ethnicity,
    this.ethnicCommunity,
    this.userType = "",
    this.residenceAreaCode = "",
  });

  UserModel copyWith({
    String? id,
    bool? isRoot,
    String? name,
    String? email,
    String? phone,
    Gender? gender,
    bool? isActive,
    bool? isDeleted,
    String? imageUrl,
    String? lastName,
    String? cityCode,
    String? cityName,
    DateTime? updateAt,
    TypeUser? typeUser,
    String? middleName,
    String? countryCode,
    DateTime? createdAt,
    String? countryName,
    BloodType? bloodType,
    DateTime? dateOfBirth,
    String? myCountryCode,
    String? residenceArea,
    String? specialization,
    String? departmentCode,
    String? departmentName,
    TimeOfDay? timeOfBirth,
    String? secondLastName,
    String? identificationType,
    String? identityDocumentUrl,
    String? signatureDocumentUrl,
    String? countryOfNationality,
    String? identificationNumber,
    String? healthAdministratorId,
    String? healthAdministratorName,
    String? healthAdministratorCode,
    String? identityDocumentBackUrl,
    String? countryOfNationalityCode,
    BiologicalSexType? biologicalSex,
    GenderIdentity? genderIdentity,
    DisabilityCategory? disabilityCategory,
    EthnicityType? ethnicity,
    String? ethnicCommunity,
    String? userType,
    String? residenceAreaCode,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        isRoot: isRoot ?? this.isRoot,
        gender: gender ?? this.gender,
        imageUrl: imageUrl ?? this.imageUrl,
        updateAt: updateAt ?? this.updateAt,
        typeUser: typeUser ?? this.typeUser,
        isActive: isActive ?? this.isActive,
        lastName: lastName ?? this.lastName,
        cityCode: cityCode ?? this.cityCode,
        cityName: cityName ?? this.cityName,
        createdAt: createdAt ?? this.createdAt,
        bloodType: bloodType ?? this.bloodType,
        isDeleted: isDeleted ?? this.isDeleted,
        middleName: middleName ?? this.middleName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        countryCode: countryCode ?? this.countryCode,
        timeOfBirth: timeOfBirth ?? this.timeOfBirth,
        countryName: countryName ?? this.countryName,
        myCountryCode: myCountryCode ?? this.myCountryCode,
        residenceArea: residenceArea ?? this.residenceArea,
        biologicalSex: biologicalSex ?? this.biologicalSex,
        secondLastName: secondLastName ?? this.secondLastName,
        departmentCode: departmentCode ?? this.departmentCode,
        departmentName: departmentName ?? this.departmentName,
        specialization: specialization ?? this.specialization,
        identificationType: identificationType ?? this.identificationType,
        identityDocumentUrl: identityDocumentUrl ?? this.identityDocumentUrl,
        identificationNumber: identificationNumber ?? this.identificationNumber,
        signatureDocumentUrl: signatureDocumentUrl ?? this.signatureDocumentUrl,
        countryOfNationality: countryOfNationality ?? this.countryOfNationality,
        identityDocumentBackUrl:
            identityDocumentBackUrl ?? this.identityDocumentBackUrl,
        healthAdministratorId:
            healthAdministratorId ?? this.healthAdministratorId,
        healthAdministratorName:
            healthAdministratorName ?? this.healthAdministratorName,
        healthAdministratorCode:
            healthAdministratorCode ?? this.healthAdministratorCode,
        countryOfNationalityCode:
            countryOfNationalityCode ?? this.countryOfNationalityCode,
        genderIdentity: genderIdentity ?? this.genderIdentity,
        disabilityCategory: disabilityCategory ?? this.disabilityCategory,
        ethnicity: ethnicity ?? this.ethnicity,
        ethnicCommunity: ethnicCommunity ?? this.ethnicCommunity,
        userType: userType ?? this.userType,
        residenceAreaCode: residenceAreaCode ?? this.residenceAreaCode,
      );

  factory UserModel.fromJson(json) => UserModel(
        id: json["id"],
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        cityCode: json["city_code"],
        cityName: json["city_name"],
        isRoot: json["is_root"] == true,
        imageUrl: json["image_url"] ?? "",
        lastName: json["last_name"] ?? "",
        countryName: json["country_name"],
        isActive: json["is_active"] != false,
        middleName: json["middle_name"] ?? "",
        residenceArea: json["residence_area"],
        isDeleted: json["is_deleted"] == true,
        departmentCode: json["department_code"],
        departmentName: json["department_name"],
        myCountryCode: json["my_country_code"],
        countryCode: json["country_code"] ?? "",
        specialization: json["specialization"] ?? "",
        typeUser: _generateTypeUser(json["type_user"]),
        secondLastName: json["second_last_name"] ?? "",
        countryOfNationality: json["country_of_nationality"],
        identificationType: json["identification_type"] ?? "",
        identityDocumentUrl: json["identity_document_url"] ?? "",
        identificationNumber: json["identification_number"] ?? "",
        healthAdministratorId: json["health_administrator_id"] ?? "",
        healthAdministratorName: (json["health_administrators"] as Map<String, dynamic>?)?["Nombre"] as String? ?? "",
        healthAdministratorCode: (json["health_administrators"] as Map<String, dynamic>?)?["Codigo"] as String? ?? "",
        signatureDocumentUrl: json["signature_document_url"] ?? "",
        countryOfNationalityCode: json["country_of_nationality_code"],
        identityDocumentBackUrl: json["identity_document_back_url"] ?? "",
        gender: json["gender"] != null ? _generateGender(json["gender"]) : null,
        bloodType: json["blood_type"] != null
            ? bloodTypeFromString(json["blood_type"])
            : null,
        updateAt: json["update_at"] != null
            ? DateTime.parse(json["update_at"])
            : DateTime.now(),
        dateOfBirth: json["date_of_birth"] != null
            ? DateTime.parse(json["date_of_birth"])
            : null,
        timeOfBirth: json["time_of_birth"] != null
            ? _parseTimeOfDay(json["time_of_birth"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        biologicalSex: json["biological_sex"] != null
            ? _generateBiologicalSexType(json["biological_sex"])
            : null,
        genderIdentity: json["gender_identity"] != null
            ? _generateGenderIdentity(json["gender_identity"])
            : null,
        disabilityCategory: json["disability_category"] != null
            ? _generateDisabilityCategory(json["disability_category"])
            : null,
        ethnicity: json["ethnicity"] != null
            ? _generateEthnicityType(json["ethnicity"])
            : null,
        ethnicCommunity: json["ethnic_community"],
        userType: json["user_type"] ?? "",
        residenceAreaCode: json["residence_area_code"] ?? "",
      );

  factory UserModel.init() => UserModel(
        name: "",
        email: "",
        phone: "",
        imageUrl: "",
        gender: null,
        lastName: "",
        isRoot: false,
        middleName: "",
        cityCode: null,
        cityName: null,
        isActive: true,
        bloodType: null,
        countryCode: "",
        isDeleted: false,
        timeOfBirth: null,
        countryName: null,
        dateOfBirth: null,
        secondLastName: "",
        specialization: "",
        myCountryCode: null,
        biologicalSex: null,
        residenceArea: null,
        departmentCode: null,
        departmentName: null,
        identificationType: "",
        identityDocumentUrl: "",
        updateAt: DateTime.now(),
        identificationNumber: "",
        signatureDocumentUrl: "",
        createdAt: DateTime.now(),
        typeUser: TypeUser.PATIENT,
        countryOfNationality: null,
        identityDocumentBackUrl: "",
        countryOfNationalityCode: null,
        healthAdministratorId: "",
        healthAdministratorName: "",
        healthAdministratorCode: "",
        genderIdentity: null,
        disabilityCategory: null,
        ethnicity: null,
        ethnicCommunity: null,
        userType: "",
        residenceAreaCode: "",
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
      "middle_name": middleName,
      "type_user": typeUser.name,
      "country_code": countryCode,
      "second_last_name": secondLastName,
      "update_at": updateAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "identification_type": identificationType,
      "identity_document_url": identityDocumentUrl,
      "identification_number": identificationNumber,
      "signature_document_url": signatureDocumentUrl,
      "identity_document_back_url": identityDocumentBackUrl,
      "specialization": specialization.isEmpty ? null : specialization,
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
    if (healthAdministratorId.isNotEmpty) {
      data["health_administrator_id"] = healthAdministratorId;
    }
    if (genderIdentity != null) {
      data["gender_identity"] = genderIdentity!.name;
    }
    if (disabilityCategory != null) {
      data["disability_category"] = disabilityCategory!.name;
    }
    if (ethnicity != null) {
      data["ethnicity"] = ethnicity!.name;
    }
    if (ethnicCommunity != null && ethnicCommunity!.isNotEmpty) {
      data["ethnic_community"] = ethnicCommunity;
    }
    if (userType.isNotEmpty) {
      data["user_type"] = userType;
    }
    if (residenceAreaCode.isNotEmpty) {
      data["residence_area_code"] = residenceAreaCode;
    }
    if (signatureDocumentUrl.isNotEmpty) {
      data["signature_document_url"] = signatureDocumentUrl;
    }
    if (id != null && id!.isNotEmpty) {
      data["id"] = id;
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
            dateOfBirth != null &&
                other.dateOfBirth != null &&
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
        healthAdministratorId == other.healthAdministratorId &&
        signatureDocumentUrl == other.signatureDocumentUrl &&
        genderIdentity == other.genderIdentity &&
        disabilityCategory == other.disabilityCategory &&
        ethnicity == other.ethnicity &&
        ethnicCommunity == other.ethnicCommunity;
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

GenderIdentity? _generateGenderIdentity(String? text) {
  if (text == null) return null;
  final upper = text.toUpperCase().replaceAll('-', '_').replaceAll(' ', '_');
  try {
    return GenderIdentity.values.firstWhere((e) => e.name == upper);
  } catch (_) {
    return null;
  }
}

DisabilityCategory? _generateDisabilityCategory(String? text) {
  if (text == null) return null;
  final upper = text.toUpperCase().replaceAll('-', '_').replaceAll(' ', '_');
  try {
    return DisabilityCategory.values.firstWhere((e) => e.name == upper);
  } catch (_) {
    return null;
  }
}

EthnicityType? _generateEthnicityType(String? text) {
  if (text == null) return null;
  final upper = text.toUpperCase().replaceAll('-', '_').replaceAll(' ', '_');
  try {
    return EthnicityType.values.firstWhere((e) => e.name == upper);
  } catch (_) {
    return null;
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

/// Parsea un string a TimeOfDay.
/// Acepta: "HH:mm", "HH:mm:ss", "HH:mm:ss.SSS", "THH:mm" (ISO), o strings con espacios.
TimeOfDay? _parseTimeOfDay(dynamic timeString) {
  if (timeString == null) return null;
  final str = timeString is String ? timeString : timeString.toString();
  if (str.isEmpty) return null;

  final trimmed = str.trim();
  if (trimmed.isEmpty) return null;

  try {
    // Extraer solo la parte de hora si viene en formato ISO (ej: "1970-01-01T09:30:00")
    String timePart = trimmed;
    if (trimmed.contains('T')) {
      final tIndex = trimmed.indexOf('T');
      timePart = trimmed.substring(tIndex + 1);
    }
    // Quitar segundos/milisegundos si existen (ej: "09:30:00" o "09:30:00.000")
    timePart = timePart.split('.')[0];

    final parts = timePart.split(':');
    if (parts.length < 2) return null;

    final hour = int.tryParse(parts[0].trim());
    final minute = int.tryParse(parts[1].trim());

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

    return TimeOfDay(hour: hour, minute: minute);
  } catch (_) {
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
