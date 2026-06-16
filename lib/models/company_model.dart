import 'package:iatros_uikit/enum/company_type.dart';
import 'package:iatros_uikit/enum/company_validation_status.dart';

class CompanyModel {
  final String? id;
  final String nit;
  final bool isActive;
  final String? nitUrl;
  final bool isDeleted;
  final DateTime createdAt; 
  final String companyName;
  final String? userOwnerId;
  final CompanyType companyType;
  final String? companyImageUrl;
  final String? address;
  final String? serviceProviderCode;
  final CompanyValidationStatus isValidated;

  CompanyModel({
    this.id,
    this.nitUrl,
    this.address,
    this.serviceProviderCode,
    this.userOwnerId,
    this.companyImageUrl,
    required this.nit,
    this.isActive = true,
    this.isDeleted = false,
    required this.createdAt,
    required this.companyName,
    required this.companyType,
    this.isValidated = CompanyValidationStatus.itIsNotValidated,
  });

  CompanyModel copyWith({
    String? id,
    String? nit,
    bool? isActive,
    String? nitUrl,
    bool? isDeleted,
    String? userOwnerId,
    DateTime? createdAt,
    String? companyName,
    CompanyType? companyType,
    String? companyImageUrl,
    String? address,
    String? serviceProviderCode,
    CompanyValidationStatus? isValidated,
  }) =>
      CompanyModel(
        id: id ?? this.id,
        nit: nit ?? this.nit,
        nitUrl: nitUrl ?? this.nitUrl,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        isDeleted: isDeleted ?? this.isDeleted,
        companyName: companyName ?? this.companyName,
        userOwnerId: userOwnerId ?? this.userOwnerId,
        companyType: companyType ?? this.companyType,
        companyImageUrl: companyImageUrl ?? this.companyImageUrl,
        address: address ?? this.address,
        serviceProviderCode: serviceProviderCode ?? this.serviceProviderCode,
        isValidated: isValidated ?? this.isValidated,
      );

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id']?.toString(),
        nitUrl: json['nit_url']?.toString(),
        isActive: json['is_active'] != false,
        isDeleted: json['is_deleted'] == true,
        userOwnerId: json['user_owner_id']?.toString(),
        companyImageUrl: json['company_image']?.toString(),
        address: json['address']?.toString(),
        serviceProviderCode: json['service_provider_code']?.toString(),
        nit: json['nit'] != null && json['nit'] != '' ? json['nit'].toString() : '',
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : DateTime.now(),
        companyType: json['company_type'] != null ? CompanyType.fromString(json['company_type'].toString()) : CompanyType.personal,
        companyName: json['company_name'] != null && json['company_name'] != '' ? json['company_name'].toString() : '',
        isValidated: json['is_validated'] != null ? CompanyValidationStatus.fromString(json['is_validated'].toString()) : CompanyValidationStatus.itIsNotValidated,
      );

  factory CompanyModel.init() => CompanyModel(
        nit: '',
        companyName: '',
        createdAt: DateTime.now(),
        companyType: CompanyType.personal,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'nit': nit,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'company_name': companyName,
      'company_type': companyType.value,
      'created_at': createdAt.toIso8601String(),
      'is_validated': isValidated.value,
    };
    if (id != null) data['id'] = id!;
    if (nitUrl != null) data['nit_url'] = nitUrl;
    if (userOwnerId != null) data['user_owner_id'] = userOwnerId;
    if (companyImageUrl != null) data['company_image'] = companyImageUrl;
    if (address != null) data['address'] = address;
    if (serviceProviderCode != null) data['service_provider_code'] = serviceProviderCode;
    return data;
  }
}
