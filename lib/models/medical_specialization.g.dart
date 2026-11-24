// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MedicalSpecialization _$MedicalSpecializationFromJson(
        Map<String, dynamic> json) =>
    _MedicalSpecialization(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$MedicalSpecializationToJson(
        _MedicalSpecialization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
    };
