import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_specialization.freezed.dart';
part 'medical_specialization.g.dart';

//specialization
@freezed
class MedicalSpecialization with _$MedicalSpecialization {
  const factory MedicalSpecialization({
    required String id,
    required String name,
    required String description,
    String? icon,
  }) = _MedicalSpecialization;

  factory MedicalSpecialization.fromJson(Map<String, dynamic> json) =>
      _$MedicalSpecializationFromJson(json);
}

// Lista de especializaciones médicas comunes
class MedicalSpecializations {
  static List<MedicalSpecialization> list = [];
  static bool _initialized = false;

  static Future<void> init(
      {required List<MedicalSpecialization> initialList}) async {
    if (_initialized) return;

    list = initialList;
    _initialized = true;
  }

  static MedicalSpecialization? getById(String id) {
    try {
      return list.firstWhere((spec) => spec.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<MedicalSpecialization> search(String query) {
    if (query.isEmpty) return list;

    return list
        .where((spec) =>
            spec.name.toLowerCase().contains(query.toLowerCase()) ||
            spec.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
