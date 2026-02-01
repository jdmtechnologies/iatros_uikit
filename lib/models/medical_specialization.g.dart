// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalSpecializationImpl _$$MedicalSpecializationImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicalSpecializationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$MedicalSpecializationImplToJson(
        _$MedicalSpecializationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
    };
