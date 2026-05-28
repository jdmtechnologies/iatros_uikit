enum CompanyValidationStatus {
  itIsNotValidated('IT_IS_NOT_VALIDATED', 'No validado'),
  inProcess('IN_PROCESS', 'En proceso'),
  validated('VALIDATED', 'Validado');

  final String value;
  final String label;

  const CompanyValidationStatus(this.value, this.label);

  static CompanyValidationStatus fromString(String value) {
    return CompanyValidationStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => CompanyValidationStatus.itIsNotValidated,
    );
  }
}
