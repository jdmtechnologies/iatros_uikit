import 'package:iatros_uikit/models/user_company_model.dart';

/// Estado de una notificación para el usuario que la ve. No se guarda en la
/// tabla `notifications`: sale de si existe su fila en `notification_reads`.
enum NotificationStatus {
  read('read'),
  unread('unread');

  final String value;

  const NotificationStatus(this.value);

  String get label => switch (this) {
    NotificationStatus.read => 'Leída',
    NotificationStatus.unread => 'No leída',
  };
}

/// Roles de la empresa que pueden leer una notificación (`target_roles`).
/// [value] coincide con [RolUser.name] para poder compararlos directo.
enum NotificationTargetRole {
  all('ALL'),
  owner('OWNER'),
  doctor('DOCTOR'),
  secretariat('SECRETARIAT');

  final String value;

  const NotificationTargetRole(this.value);

  String get label => switch (this) {
    NotificationTargetRole.all => 'Todos',
    NotificationTargetRole.owner => 'Propietario',
    NotificationTargetRole.doctor => 'Doctor',
    NotificationTargetRole.secretariat => 'Secretariado',
  };

  /// Si un usuario con [rol] en la empresa entra en este destino.
  bool matches(RolUser rol) =>
      this == NotificationTargetRole.all || value == rol.name;

  static NotificationTargetRole? fromValue(String? value) {
    for (final role in values) {
      if (role.value == value) return role;
    }
    return null;
  }
}

/// A qué empresas llega una notificación (`company_scope`): a todas o solo a
/// las de `target_company_ids`.
enum NotificationCompanyScope {
  all('ALL'),
  selected('SELECTED');

  final String value;

  const NotificationCompanyScope(this.value);

  String get label => switch (this) {
    NotificationCompanyScope.all => 'Todas las empresas',
    NotificationCompanyScope.selected => 'Empresas seleccionadas',
  };

  static NotificationCompanyScope fromValue(String? value) =>
      value == NotificationCompanyScope.selected.value
      ? NotificationCompanyScope.selected
      : NotificationCompanyScope.all;
}
