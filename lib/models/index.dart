import 'package:iatros_ui/models/input_type.dart';
import 'package:iatros_ui/models/gender_type.dart';
import 'package:iatros_ui/models/blood_type.dart';

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
}
