import 'package:iatros_uikit/models/input_type.dart';
import 'package:iatros_uikit/models/gender_type.dart';
import 'package:iatros_uikit/models/blood_type.dart';
import 'package:iatros_uikit/models/biological_sex_type.dart';
import 'package:iatros_uikit/models/gender_identity_type.dart';
import 'package:iatros_uikit/models/disability_category.dart';
import 'package:iatros_uikit/models/ethnicity_type.dart';

/// Agrupa todos los modelos y tipos del paquete.
class Models {
  Models._();
  static final Models _instance = Models._();
  factory Models() => _instance;

  /// Tipo de input (dark / light).
  InputType get inputType => InputType.dark;

  /// Enums y tipos expuestos para uso externo.
  Type get genderType => Gender;
  Type get bloodType => BloodType;
  Type get biologicalSexType => BiologicalSexType;
}
