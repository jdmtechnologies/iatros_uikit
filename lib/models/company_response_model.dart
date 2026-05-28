import 'dart:convert';
import 'package:iatros_uikit/enum/company_response_status.dart';

class CompanyResponseModel {
  final String company;
  final String message;
  final String id;
  final CompanyResponseStatus status;

  CompanyResponseModel({
    required this.company,
    required this.message,
    required this.id,
    this.status = CompanyResponseStatus.noGenerated,
  });

  CompanyResponseModel copyWith({
    String? company,
    String? message,
    String? id,
    CompanyResponseStatus? status,
  }) =>
      CompanyResponseModel(
        company: company ?? this.company,
        message: message ?? this.message,
        id: id ?? this.id,
        status: status ?? this.status,
      );

  factory CompanyResponseModel.fromRawJson(String str) =>
      CompanyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) =>
      CompanyResponseModel(
        company: json['company']?.toString() ?? '',
        message: json['message']?.toString() ?? '',
        id: json['id']?.toString() ?? '',
        status: json['status'] != null
            ? CompanyResponseStatus.fromString(json['status'].toString())
            : CompanyResponseStatus.noGenerated,
      );

  Map<String, dynamic> toJson() => {
        'company': company,
        'message': message,
        'id': id,
        'status': status.value,
      };
}
