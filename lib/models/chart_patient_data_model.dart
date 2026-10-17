import 'package:iatros_uikit/models/chart_template_model.dart';
import 'package:iatros_uikit/models/gender_type.dart';

/// Datos de un paciente para las gráficas, en sus unidades de origen: la
/// fecha de nacimiento (no la edad) y la altura en centímetros, como se
/// escriben en la historia clínica. [numericValueOf] los convierte a la
/// unidad de cada [PhysicalExamField] (meses o años, cm o metros).
class ChartPatientDataModel {
  /// Cuándo se tomaron los datos (la consulta); la edad se calcula a esta
  /// fecha. Por defecto, ahora.
  final DateTime measuredAt;

  final DateTime? dateOfBirth;
  final Gender? gender;

  final double? fc;
  final double? systolic;
  final double? diastolic;
  final double? tam;
  final double? fr;
  final double? temperature;
  final double? so2;
  final double? heightCm;
  final double? weight;
  final double? imc;

  ChartPatientDataModel({
    DateTime? measuredAt,
    this.dateOfBirth,
    this.gender,
    this.fc,
    this.systolic,
    this.diastolic,
    this.tam,
    this.fr,
    this.temperature,
    this.so2,
    this.heightCm,
    this.weight,
    this.imc,
  }) : measuredAt = measuredAt ?? DateTime.now();

  /// Valor de [field] en su unidad; `null` si el paciente no lo tiene (o
  /// [field] es [PhysicalExamField.gender], que no es numérico: ver
  /// [gender]). La edad va en meses o años **cumplidos**, sin decimales (ver
  /// [ageInCompletedMonths]).
  double? numericValueOf(PhysicalExamField field) {
    switch (field) {
      case PhysicalExamField.fc:
        return fc;
      case PhysicalExamField.systolic:
        return systolic;
      case PhysicalExamField.diastolic:
        return diastolic;
      case PhysicalExamField.tam:
        return tam;
      case PhysicalExamField.fr:
        return fr;
      case PhysicalExamField.temperature:
        return temperature;
      case PhysicalExamField.so2:
        return so2;
      case PhysicalExamField.heightCm:
        return heightCm;
      case PhysicalExamField.heightM:
        final cm = heightCm;
        return cm == null ? null : cm / 100;
      case PhysicalExamField.weight:
        return weight;
      case PhysicalExamField.imc:
        return imc;
      case PhysicalExamField.ageMonths:
        return ageInCompletedMonths?.toDouble();
      case PhysicalExamField.ageYears:
        final months = ageInCompletedMonths;
        return months == null ? null : (months ~/ 12).toDouble();
      case PhysicalExamField.gender:
        return null;
    }
  }

  /// Meses cumplidos entre [dateOfBirth] y [measuredAt], contados por
  /// calendario: el mes solo se cumple al llegar al mismo día del mes de
  /// nacimiento (nacido el 15 de enero: el 14 de marzo tiene 1 mes, el 15 de
  /// marzo 2). Nacido el 31, en un mes más corto se cumple el último día.
  /// `null` sin fecha de nacimiento o si es posterior a [measuredAt].
  int? get ageInCompletedMonths {
    final dob = dateOfBirth;
    if (dob == null || measuredAt.isBefore(dob)) return null;
    var months =
        (measuredAt.year - dob.year) * 12 + (measuredAt.month - dob.month);
    final lastDayOfMonth =
        DateTime(measuredAt.year, measuredAt.month + 1, 0).day;
    final birthDayThisMonth =
        dob.day > lastDayOfMonth ? lastDayOfMonth : dob.day;
    if (measuredAt.day < birthDayThisMonth) months--;
    return months;
  }
}
