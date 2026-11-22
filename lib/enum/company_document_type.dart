/// Documento con el que se identifica la empresa (columna
/// `companies.document_type`). A este documento se emite la factura
/// electrónica de su suscripción. Un consultorio puede estar a nombre de una
/// persona natural (cédula).
enum CompanyDocumentType {
  nit('NIT', 'NIT'),
  cc('CC', 'Cédula de ciudadanía');

  final String value;
  final String label;

  const CompanyDocumentType(this.value, this.label);

  /// Las empresas existentes (sin valor) quedan con NIT.
  static CompanyDocumentType fromString(String? value) {
    return CompanyDocumentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => CompanyDocumentType.nit,
    );
  }
}
