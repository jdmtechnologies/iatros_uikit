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

/// Qué hay detrás de la URL de una notificación (`url_type`). Define cómo se
/// muestra: la imagen dentro de la notificación, la miniatura del video con
/// botón de play (como WhatsApp) o un botón para abrir el documento.
enum NotificationMediaType {
  image('IMAGE'),
  video('VIDEO'),
  document('DOCUMENT');

  final String value;

  const NotificationMediaType(this.value);

  String get label => switch (this) {
    NotificationMediaType.image => 'Imagen',
    NotificationMediaType.video => 'Video',
    NotificationMediaType.document => 'Documento',
  };

  static NotificationMediaType? fromValue(String? value) {
    for (final type in values) {
      if (type.value == value) return type;
    }
    return null;
  }

  static final _videoPattern = RegExp(
    r'(youtube\.com|youtu\.be|vimeo\.com|loom\.com|drive\.google\.com/file)'
    r'|\.(mp4|webm|mov|m4v|ogv)(\?|#|$)',
  );
  static final _imagePattern = RegExp(
    r'\.(png|jpe?g|gif|webp|bmp|svg|avif)(\?|#|$)',
  );

  /// Adivina el tipo por la URL; si no es imagen ni video, es documento.
  static NotificationMediaType detect(String url) {
    final u = url.trim().toLowerCase();
    if (_videoPattern.hasMatch(u)) return NotificationMediaType.video;
    if (_imagePattern.hasMatch(u)) return NotificationMediaType.image;
    return NotificationMediaType.document;
  }
}
