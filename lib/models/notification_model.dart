import 'package:iatros_uikit/enum/notification_enums.dart';
import 'package:iatros_uikit/models/user_company_model.dart';

/// Una fila de `notifications` (ver
/// `iatros/supabase/sql/create_notifications_tables.sql`). La crea un admin
/// en iatros_administration y la leen en iatros los usuarios de las empresas
/// y roles a los que va dirigida.
///
/// [status] y [readAt] son del usuario que la consulta (su fila en
/// `notification_reads`); [readCount] solo lo llena el admin para medir
/// cuántas personas la leyeron.
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final List<NotificationTargetRole> targetRoles;
  final NotificationCompanyScope companyScope;

  /// Empresas que la ven cuando [companyScope] es `selected`.
  final List<String> targetCompanyIds;
  final bool isActive;
  final DateTime createdAt;

  /// Desde esta fecha deja de mostrarse. Null = no caduca.
  final DateTime? dateEnd;
  final String? createdBy;

  /// Enlace opcional (ej. un video de YouTube) que se abre en otra pestaña.
  final String? url;

  /// Texto del botón del enlace. Si está vacío se usa [defaultUrlLabel].
  final String? urlLabel;

  final NotificationStatus status;
  final DateTime? readAt;
  final int readCount;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.targetRoles,
    required this.companyScope,
    required this.targetCompanyIds,
    required this.isActive,
    required this.createdAt,
    this.dateEnd,
    this.createdBy,
    this.url,
    this.urlLabel,
    this.status = NotificationStatus.unread,
    this.readAt,
    this.readCount = 0,
  });

  factory NotificationModel.init() => NotificationModel(
    id: '',
    title: '',
    message: '',
    targetRoles: const [NotificationTargetRole.all],
    companyScope: NotificationCompanyScope.all,
    targetCompanyIds: const [],
    isActive: true,
    createdAt: DateTime.now(),
  );

  bool get isRead => status == NotificationStatus.read;

  bool get isExpired => dateEnd != null && dateEnd!.isBefore(DateTime.now());

  bool get hasUrl => url != null && url!.trim().isNotEmpty;

  /// Si [url] apunta a un video (YouTube, Vimeo, Loom, Drive o un archivo de
  /// video), para mostrar el ícono y el texto adecuados.
  bool get isVideoUrl {
    if (!hasUrl) return false;
    final u = url!.toLowerCase();
    return RegExp(
      r'(youtube\.com|youtu\.be|vimeo\.com|loom\.com|drive\.google\.com/file)'
      r'|\.(mp4|webm|mov|m4v)(\?|#|$)',
    ).hasMatch(u);
  }

  String get defaultUrlLabel => isVideoUrl ? 'Ver video' : 'Abrir enlace';

  /// Texto del botón: [urlLabel] o, si no hay, [defaultUrlLabel].
  String get effectiveUrlLabel =>
      (urlLabel ?? '').trim().isNotEmpty ? urlLabel!.trim() : defaultUrlLabel;

  /// Valida que [value] sea una URL http(s) con dominio.
  static bool isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.contains('.');
  }

  /// Si la ve un usuario con [role] en la empresa [companyId]. La base de
  /// datos (RLS) ya filtra por las empresas del usuario; esto deja solo las de
  /// la empresa seleccionada en la app.
  bool isVisibleFor({required String companyId, required RolUser role}) {
    if (!isActive || isExpired) return false;
    final companyOk =
        companyScope == NotificationCompanyScope.all ||
        targetCompanyIds.contains(companyId);
    return companyOk && targetRoles.any((r) => r.matches(role));
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    List<NotificationTargetRole>? targetRoles,
    NotificationCompanyScope? companyScope,
    List<String>? targetCompanyIds,
    bool? isActive,
    DateTime? createdAt,
    DateTime? dateEnd,
    bool clearDateEnd = false,
    String? createdBy,
    String? url,
    String? urlLabel,
    bool clearUrl = false,
    NotificationStatus? status,
    DateTime? readAt,
    int? readCount,
  }) => NotificationModel(
    id: id ?? this.id,
    title: title ?? this.title,
    message: message ?? this.message,
    targetRoles: targetRoles ?? this.targetRoles,
    companyScope: companyScope ?? this.companyScope,
    targetCompanyIds: targetCompanyIds ?? this.targetCompanyIds,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    dateEnd: clearDateEnd ? null : (dateEnd ?? this.dateEnd),
    createdBy: createdBy ?? this.createdBy,
    url: clearUrl ? null : (url ?? this.url),
    urlLabel: clearUrl ? null : (urlLabel ?? this.urlLabel),
    status: status ?? this.status,
    readAt: readAt ?? this.readAt,
    readCount: readCount ?? this.readCount,
  );

  /// Acepta el embed `notification_reads` de dos formas:
  /// - `notification_reads(read_at)` (iatros): por RLS solo trae la lectura
  ///   del usuario, si existe → [status] leída.
  /// - `notification_reads(count)` (admin) → [readCount].
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final reads = (json['notification_reads'] as List?) ?? const [];
    DateTime? readAt;
    var readCount = 0;
    for (final r in reads.whereType<Map>()) {
      if (r['count'] != null) readCount = (r['count'] as num).toInt();
      if (r['read_at'] != null) readAt = DateTime.parse(r['read_at']).toLocal();
    }

    final roles = ((json['target_roles'] as List?) ?? const [])
        .map((e) => NotificationTargetRole.fromValue(e?.toString()))
        .whereType<NotificationTargetRole>()
        .toList();

    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      targetRoles: roles.isEmpty ? const [NotificationTargetRole.all] : roles,
      companyScope: NotificationCompanyScope.fromValue(json['company_scope']),
      targetCompanyIds: ((json['target_company_ids'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : DateTime.now(),
      dateEnd: json['date_end'] != null
          ? DateTime.parse(json['date_end']).toLocal()
          : null,
      createdBy: json['created_by'],
      url: json['url'],
      urlLabel: json['url_label'],
      status: readAt != null
          ? NotificationStatus.read
          : NotificationStatus.unread,
      readAt: readAt,
      readCount: readCount,
    );
  }

  /// Columnas editables de `notifications` (sin id, fechas de sistema ni
  /// datos de lectura).
  Map<String, dynamic> toJson() => {
    'title': title,
    'message': message,
    'target_roles': targetRoles.map((r) => r.value).toList(),
    'company_scope': companyScope.value,
    'target_company_ids': companyScope == NotificationCompanyScope.all
        ? <String>[]
        : targetCompanyIds,
    'is_active': isActive,
    'date_end': dateEnd?.toUtc().toIso8601String(),
    'url': hasUrl ? url!.trim() : null,
    'url_label': hasUrl && (urlLabel ?? '').trim().isNotEmpty
        ? urlLabel!.trim()
        : null,
  };
}
