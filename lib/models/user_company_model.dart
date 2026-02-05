
import 'package:iatros_uikit/models/company_model.dart';
import 'package:iatros_uikit/models/user_model.dart';

enum Status { ENABLED, DISABLED, DELETED }

enum RolUser { OWNER, SECRETARIAT, DOCTOR }

extension StatusExtension on Status {
  String get toName {
    switch (this) {
      case Status.ENABLED:
        return 'Activo';
      case Status.DISABLED:
        return 'Desactivado';
      case Status.DELETED:
        return 'Eliminado';
    }
  }
}

extension RolUserExtension on RolUser {
  String get toName {
    switch (this) {
      case RolUser.OWNER:
        return 'Propietario';
      case RolUser.SECRETARIAT:
        return 'Secretariado';
      case RolUser.DOCTOR:
        return 'Doctor';
    }
  }
}

class UserCompanyModel {
  final String? id;
  final String userId;
  final Status status;
  final RolUser rolUser;
  final UserModel? user;
  final String companyId;
  final DateTime createdAt;
  final CompanyModel? company;

  UserCompanyModel({
    this.id,
    this.user,
    this.company,
    required this.userId,
    required this.status,
    required this.rolUser,
    required this.companyId,
    required this.createdAt,
  });

  UserCompanyModel copyWith({
    String? id,
    String? userId,
    Status? status,
    UserModel? user,
    RolUser? rolUser,
    String? companyId,
    DateTime? createdAt,
    CompanyModel? company,
  }) => UserCompanyModel(
    id: id ?? this.id,
    user: user ?? this.user,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    rolUser: rolUser ?? this.rolUser,
    company: company ?? this.company,
    companyId: companyId ?? this.companyId,
    createdAt: createdAt ?? this.createdAt,
  );

  factory UserCompanyModel.init() => UserCompanyModel(
    userId: "",
    companyId: "",
    status: Status.ENABLED,
    createdAt: DateTime.now(),
    rolUser: RolUser.SECRETARIAT,
  );

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) =>
      UserCompanyModel(
        id: json["id"],
        userId: json["user_id"] ?? "",
        companyId: json["company_id"] ?? "",
        user: json["users"] != null ? UserModel.fromJson(json["users"]) : null,
        status: generateStatus(json["status"]),
        rolUser: generateRolUser(json["rol_user"]),
        company: json["company"] != null ? CompanyModel.fromJson(json["company"]) : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "status": status.name,
    "company_id": companyId,
    "rol_user": rolUser.name,
    "created_at": createdAt.toIso8601String(),
  };
}

Status generateStatus(String item) {
  if (item == Status.ENABLED.name) return Status.ENABLED;
  if (item == Status.DISABLED.name) return Status.DISABLED;
  if (item == Status.DELETED.name) return Status.DELETED;
  return Status.ENABLED;
}

RolUser generateRolUser(String? item) {
  if (item == RolUser.OWNER.name) return RolUser.OWNER;
  if (item == RolUser.DOCTOR.name) return RolUser.DOCTOR;
  if (item == RolUser.SECRETARIAT.name) return RolUser.SECRETARIAT;
  return RolUser.DOCTOR;
}
