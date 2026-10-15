import 'package:iatros_uikit/models/chart_patient_data_model.dart';
import 'package:iatros_uikit/models/chart_template_model.dart';

extension ChartParameterValidation on ChartParameterModel {
  /// `true` si [patient] cumple este parámetro, convirtiendo su dato a la
  /// unidad de [ChartParameterModel.item]: con `ageYears < 5` y
  /// `ageMonths < 60` el mismo paciente da el mismo resultado, igual que con
  /// `heightCm > 100` y `heightM > 1`.
  ///
  /// Si el paciente no tiene el dato (sin fecha de nacimiento, campo vacío o
  /// sin género) no se puede confirmar, así que devuelve `false`.
  bool isSatisfiedBy(ChartPatientDataModel patient) {
    if (!item.isNumeric) {
      final patientGender = patient.gender;
      return patientGender != null && matchesGender(patientGender);
    }
    final patientValue = patient.numericValueOf(item);
    return patientValue != null && matches(patientValue);
  }
}

extension ChartTemplateValidation on ChartTemplateModel {
  /// `true` si [patient] cumple **todos** los parámetros de
  /// [ChartTemplateModel.parameterization]; sin parámetros, la plantilla
  /// aplica a todos los pacientes.
  bool matchesParameterization(ChartPatientDataModel patient) =>
      parameterization.every((p) => p.isSatisfiedBy(patient));
}
