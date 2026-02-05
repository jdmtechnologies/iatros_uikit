import 'package:iatros_uikit/iatros_ui_kit.dart';

enum TypeUser { MEDICAL_STAFF, PATIENT }

class UserModel {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String imageUrl;
  final Gender? gender;
  final String address;
  final String lastName;
  final double? latitude;
  final double? longitude;
  final TypeUser typeUser;
  final DateTime updateAt;
  final String countryCode;
  final DateTime createdAt;
  final BloodType? bloodType;
  final String specialization;
  final String medicalLicense;
  final DateTime? dateOfBirth;
  final String identificationType;
  final String professionalCardUrl;
  final String identityDocumentUrl;
  final String professionalCardBackUrl;
  final String identityDocumentBackUrl;
  final String identificationNumber;
  final String professionalBiography;
  final bool isDeleted;
  final bool isActive;
  final bool isRoot;

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
    required this.medicalLicense,
    required this.specialization,
    required this.identificationType,
    required this.professionalCardUrl,
    required this.professionalCardBackUrl,
    required this.identityDocumentUrl,
    required this.identityDocumentBackUrl,
    required this.professionalBiography,
    required this.identificationNumber,
    this.isDeleted = false,
    this.isActive = true,
    this.isRoot = false,
    this.address = "",
    this.latitude,
    this.longitude,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
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
    String? medicalLicense,
    String? professionalCardUrl,
    String? professionalCardBackUrl,
    String? identityDocumentUrl,
    String? identityDocumentBackUrl,
    String? professionalBiography,
    String? identificationType,
    String? identificationNumber,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? dateOfBirth,
    Gender? gender,
    BloodType? bloodType,
    bool? isDeleted,
    bool? isActive,
    bool? isRoot,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    gender: gender ?? this.gender,
    imageUrl: imageUrl ?? this.imageUrl,
    address: address ?? this.address,
    latitude: latitude ?? this.latitude,
    updateAt: updateAt ?? this.updateAt,
    typeUser: typeUser ?? this.typeUser,
    lastName: lastName ?? this.lastName,
    longitude: longitude ?? this.longitude,
    bloodType: bloodType ?? this.bloodType,
    createdAt: createdAt ?? this.createdAt,
    countryCode: countryCode ?? this.countryCode,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    medicalLicense: medicalLicense ?? this.medicalLicense,
    specialization: specialization ?? this.specialization,
    identificationType: identificationType ?? this.identificationType,
    professionalCardUrl: professionalCardUrl ?? this.professionalCardUrl,
    professionalCardBackUrl: professionalCardBackUrl ?? this.professionalCardBackUrl,
    identityDocumentUrl: identityDocumentUrl ?? this.identityDocumentUrl,
    identityDocumentBackUrl:
        identityDocumentBackUrl ?? this.identityDocumentBackUrl,
    identificationNumber: identificationNumber ?? this.identificationNumber,
    professionalBiography: professionalBiography ?? this.professionalBiography,
    isDeleted: isDeleted ?? this.isDeleted,
    isActive: isActive ?? this.isActive,
    isRoot: isRoot ?? this.isRoot,
  );

  factory UserModel.fromJson(json) => UserModel(
    id: json["id"],
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    address: json["address"] ?? "",
    imageUrl: json["image_url"] ?? "",
    lastName: json["last_name"] ?? "",
    latitude: json["latitude"]?.toDouble(),
    countryCode: json["country_code"] ?? "",
    longitude: json["longitude"]?.toDouble(),
    specialization: json["specialization"] ?? "",
    medicalLicense: json["medical_license"] ?? "",
    typeUser: _generateTypeUser(json["type_user"]),
    identificationType: json["identification_type"] ?? "",
    professionalCardUrl: json["professional_card_url"] ?? "",
    professionalCardBackUrl: json["professional_card_back_url"] ?? "",
    identityDocumentUrl: json["identity_document_url"] ?? "",
    professionalBiography: json["professional_biography"] ?? "",
    identificationNumber: json["identification_number"] ?? "",
    identityDocumentBackUrl: json["identity_document_back_url"] ?? "",
    gender: json["gender"] != null ? _generateGender(json["gender"]) : null,
    bloodType: json["blood_type"] != null ? bloodTypeFromString(json["blood_type"]) : null,
    updateAt: json["update_at"] != null ? DateTime.parse(json["update_at"]): DateTime.now(),
    dateOfBirth: json["date_of_birth"] != null ? DateTime.parse(json["date_of_birth"]) : null,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    isDeleted: json["is_deleted"] == true,
    isActive: json["is_active"] != false,
    isRoot: json["is_root"] == true,
  );

  factory UserModel.init() => UserModel(
    name: "",
    email: "",
    phone: "",
    address: "",
    imageUrl: "",
    lastName: "",
    gender: null,
    latitude: null,
    longitude: null,
    bloodType: null,
    countryCode: "",
    dateOfBirth: null,
    specialization: "",
    medicalLicense: "",
    identificationType: "",
    professionalCardUrl: "",
    professionalCardBackUrl: "",
    identityDocumentUrl: "",
    updateAt: DateTime.now(),
    identificationNumber: "",
    createdAt: DateTime.now(),
    professionalBiography: "",
    typeUser: TypeUser.PATIENT,
    identityDocumentBackUrl: "",
    isDeleted: false,
    isActive: true,
    isRoot: false,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
      "is_root": isRoot,
      "address": address,
      "image_url": imageUrl,
      "last_name": lastName,
      "is_active": isActive,
      "is_deleted": isDeleted,
      "type_user": typeUser.name,
      "country_code": countryCode,
      "medical_license": medicalLicense,
      "update_at": updateAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "identification_type": identificationType,
      "professional_card_url": professionalCardUrl,
      "professional_card_back_url": professionalCardBackUrl,
      "identity_document_url": identityDocumentUrl,
      "identification_number": identificationNumber,
      "professional_biography": professionalBiography,
      "identity_document_back_url": identityDocumentBackUrl,
      "specialization": specialization.isEmpty ? null : specialization,
    };

    if (id != null) data["id"] = id!;
    if (dateOfBirth != null) {
      data["date_of_birth"] = dateOfBirth!.toIso8601String();
    }
    if (gender != null) {
      data["gender"] = gender!.name;
    }
    if (bloodType != null) {
      data["blood_type"] = bloodType!.value;
    }
    if (latitude != null) {
      data["latitude"] = latitude;
    }
    if (longitude != null) {
      data["longitude"] = longitude;
    }

    return data;
  }

  bool compareWith(UserModel other) {
    return id == other.id &&
      name == other.name &&
      phone == other.phone &&
      email == other.email &&
      gender == other.gender &&
      address == other.address &&
      lastName == other.lastName &&
      typeUser == other.typeUser &&
      latitude == other.latitude &&
      longitude == other.longitude &&
      bloodType == other.bloodType &&
      countryCode == other.countryCode &&
      specialization == other.specialization &&
      medicalLicense == other.medicalLicense && 
      (dateOfBirth == null && other.dateOfBirth == null ||
        dateOfBirth != null && other.dateOfBirth != null &&
        dateOfBirth!.isAtSameMomentAs(other.dateOfBirth!)) &&
      identificationType == other.identificationType &&
      professionalCardUrl == other.professionalCardUrl &&
      professionalCardBackUrl == other.professionalCardBackUrl &&
      identityDocumentUrl == other.identityDocumentUrl &&
      identityDocumentBackUrl == other.identityDocumentBackUrl &&
      identificationNumber == other.identificationNumber &&
      professionalBiography == other.professionalBiography &&
      isDeleted == other.isDeleted &&
      isActive == other.isActive &&
      isRoot == other.isRoot;
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
