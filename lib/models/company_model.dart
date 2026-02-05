import 'package:iatros_uikit/enum/company_type.dart';

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

  CompanyModel({
    this.id,
    this.nitUrl,
    this.userOwnerId,
    required this.nit,
    this.isActive = true,
    this.isDeleted = false,
    required this.createdAt,
    required this.companyName,
    required this.companyType,
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
      );

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id']?.toString(),
        nitUrl: json['nit_url']?.toString(),
        isActive: json['is_active'] != false,
        isDeleted: json['is_deleted'] == true,
        nit: json['nit'] != null && json['nit'] != '' ? json['nit'].toString() : 'No tiene NIT',
        userOwnerId: json['user_owner_id']?.toString(),
        companyName: json['company_name'] != null && json['company_name'] != '' ? json['company_name'].toString() : 'No tiene nombre',
        companyType: json['company_type'] != null
            ? CompanyType.fromString(json['company_type'].toString())
            : CompanyType.personal,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : DateTime.now(),
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
    };
    if (id != null) data['id'] = id!;
    if (nitUrl != null) data['nit_url'] = nitUrl;
    if (userOwnerId != null) data['user_owner_id'] = userOwnerId;
    return data;
  }
}
