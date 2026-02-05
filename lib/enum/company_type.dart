enum CompanyType {
  personal('personal', 'Personal'),
  company('company', 'Empresa');

  final String value;
  final String label;

  const CompanyType(this.value, this.label);

  static CompanyType fromString(String value) {
    return CompanyType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => CompanyType.personal,
    );
  }
}