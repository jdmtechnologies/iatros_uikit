
extension StringExtension on String {
  bool get isActive {
    return this == "APPROVED";
  }

  /// Divide el texto por espacios y pone la primera letra de cada palabra en mayúscula.
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}