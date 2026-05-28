enum CompanyResponseStatus {
  noGenerated('NO_GENERATED', 'Not generated'),
  errorMessage('ERROR_MESSAGE', 'Error'),
  successMessage('SUCCESS_MESSAGE', 'Success');

  final String value;
  final String label;

  const CompanyResponseStatus(this.value, this.label);

  static CompanyResponseStatus fromString(String value) {
    return CompanyResponseStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => CompanyResponseStatus.noGenerated,
    );
  }
}
