import 'package:iatros_uikit/enum/company_type.dart';

class CompanyModel {
  final String? id;
  final String nit;
  final String companyName;
  final String nitUrl;
  final DateTime createdAt;
  final String userOwnerId;
  final CompanyType companyType;

  CompanyModel({
    this.id,
    required this.nit,
    required this.companyName,
    required this.nitUrl,
    required this.createdAt,
    required this.userOwnerId,
    required this.companyType,
  });

  CompanyModel copyWith({
    String? id,
    String? nit,
    String? nitUrl,
    String? companyName,
    DateTime? createdAt,
    String? userOwnerId,
    CompanyType? companyType,
  }) => CompanyModel(
    id: id ?? this.id,
    nit: nit ?? this.nit,
    companyName: companyName ?? this.companyName,
    nitUrl: nitUrl ?? this.nitUrl,
    createdAt: createdAt ?? this.createdAt,
    userOwnerId: userOwnerId ?? this.userOwnerId,
    companyType: companyType ?? this.companyType,
  );

  factory CompanyModel.init() => CompanyModel(
    nit: "",
    companyName: "",
    nitUrl: "",
    userOwnerId: "",
    createdAt: DateTime.now(),
    companyType: CompanyType.personal,
  );


  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["id"],
    nit: json["nit"],
    nitUrl: json["nit_url"],
    companyName: json["company_name"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : DateTime.now(),
    companyType: CompanyType.values.firstWhere(
      (element) => element.value == json["company_type"],
      orElse: () => CompanyType.company,
    ),
    userOwnerId: json["user_owner_id"],
  );

  Map<String, dynamic> toJson() => {
    "nit": nit,
    "nit_url": nitUrl,
    "company_name": companyName,
    "user_owner_id": userOwnerId,
    "company_type": companyType.value,
    "created_at": createdAt.toIso8601String(),
  };
}
