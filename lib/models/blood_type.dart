enum BloodType {
  oPositive,  // O+
  oNegative,  // O-
  aPositive,  // A+
  aNegative,  // A-
  bPositive,  // B+
  bNegative,  // B-
  abPositive, // AB+
  abNegative, // AB-
}

extension BloodTypeExtension on BloodType {
  String get displayName {
    switch (this) {
      case BloodType.oPositive:
        return 'O+';
      case BloodType.oNegative:
        return 'O-';
      case BloodType.aPositive:
        return 'A+';
      case BloodType.aNegative:
        return 'A-';
      case BloodType.bPositive:
        return 'B+';
      case BloodType.bNegative:
        return 'B-';
      case BloodType.abPositive:
        return 'AB+';
      case BloodType.abNegative:
        return 'AB-';
    }
  }

  String get value {
    switch (this) {
      case BloodType.oPositive:
        return 'O+';
      case BloodType.oNegative:
        return 'O-';
      case BloodType.aPositive:
        return 'A+';
      case BloodType.aNegative:
        return 'A-';
      case BloodType.bPositive:
        return 'B+';
      case BloodType.bNegative:
        return 'B-';
      case BloodType.abPositive:
        return 'AB+';
      case BloodType.abNegative:
        return 'AB-';
    }
  }
}

BloodType? bloodTypeFromString(String value) {
  switch (value) {
    case 'O+':
      return BloodType.oPositive;
    case 'O-':
      return BloodType.oNegative;
    case 'A+':
      return BloodType.aPositive;
    case 'A-':
      return BloodType.aNegative;
    case 'B+':
      return BloodType.bPositive;
    case 'B-':
      return BloodType.bNegative;
    case 'AB+':
      return BloodType.abPositive;
    case 'AB-':
      return BloodType.abNegative;
    default:
      return null;
  }
}

