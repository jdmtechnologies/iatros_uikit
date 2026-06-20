enum SubscriptionType {
  professionalIndependent,
  ipsEssential,
  ipsAdvanced,
  ipsInstitutional,
}

extension SubscriptionTypeExtension on SubscriptionType {
  String get toName {
    switch (this) {
      case SubscriptionType.professionalIndependent:
        return 'Profesional Independiente';
      case SubscriptionType.ipsEssential:
        return 'IPS Esencial';
      case SubscriptionType.ipsAdvanced:
        return 'IPS Avanzado';
      case SubscriptionType.ipsInstitutional:
        return 'IPS Institucional';
    }
  }
}
