enum EmailType {
  success('success', 'success'),
  info('info', 'info'),
  alert('alert', 'alert');

  final String value;
  final String label;

  const EmailType(this.value, this.label);
}
