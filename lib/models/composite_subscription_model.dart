import 'package:iatros_uikit/enum/subscription_module.dart';
import 'package:iatros_uikit/models/suscription_settings_model.dart';

/// Suscripción a la medida creada sobre un plan base de
/// `subscriptions_settings` (tabla `composite_subscription_configuration`).
///
/// - [maxUsers]: DOCTOR + OWNER. `null` = sin límite.
/// - [maxCollaborators]: resto de roles. `null` = sin límite.
/// - [modules] vacío = hereda los módulos del plan base.
/// - No se combina con códigos de descuento.
class CompositeSubscriptionModel {
  final String? id;
  final String baseSubscriptionId;
  final String title;
  final String description;
  final double discount;
  final int? priceOverride;
  final int? rangeMonthOverride;
  final int? maxUsers;
  final int? maxCollaborators;
  final Set<SubscriptionModule> modules;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final int? maxRedemptions;
  final bool isActive;
  final String internalNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Plan base (viene del join `base:base_subscription_id(*)`).
  final SuscriptionSettingsModel? base;

  /// Empresas asignadas (solo se llena en administración).
  final List<String> companyIds;

  const CompositeSubscriptionModel({
    this.id,
    required this.baseSubscriptionId,
    required this.title,
    this.description = '',
    this.discount = 0,
    this.priceOverride,
    this.rangeMonthOverride,
    this.maxUsers,
    this.maxCollaborators,
    this.modules = const <SubscriptionModule>{},
    this.validFrom,
    this.validUntil,
    this.maxRedemptions,
    this.isActive = true,
    this.internalNotes = '',
    this.createdAt,
    this.updatedAt,
    this.base,
    this.companyIds = const <String>[],
  });

  /// Precio antes del descuento: el fijo de la compuesta o el del plan base.
  int? get listPrice => priceOverride ?? base?.price;

  /// Precio final (misma fórmula que el payment-service).
  int? get finalPrice {
    final p = listPrice;
    if (p == null) return null;
    final discounted = p - (p * (discount / 100)).round();
    return discounted < 0 ? 0 : discounted;
  }

  int? get rangeMonth => rangeMonthOverride ?? base?.rangeMonth;

  /// Activa y dentro de su vigencia: se puede comprar.
  bool isPurchasableAt(DateTime now) {
    if (!isActive) return false;
    if (validFrom != null && now.isBefore(validFrom!)) return false;
    if (validUntil != null && !now.isBefore(validUntil!)) return false;
    return true;
  }

  static String? _parseId(dynamic v) {
    if (v == null) return null;
    return v.toString();
  }

  static int? _parseInt(dynamic v) => v is num ? v.toInt() : null;

  static DateTime? _parseDate(dynamic v) =>
      v is String ? DateTime.tryParse(v) : (v is DateTime ? v : null);

  factory CompositeSubscriptionModel.fromJson(Map<String, dynamic> json) {
    SuscriptionSettingsModel? base;
    final rawBase = json['base'];
    if (rawBase is Map<String, dynamic>) {
      try {
        base = SuscriptionSettingsModel.fromJson(rawBase);
      } catch (_) {
        base = null;
      }
    }

    final rawCompanies = json['companies'];
    final companyIds = rawCompanies is List
        ? rawCompanies
              .map((e) => e is Map ? e['company_id']?.toString() : e?.toString())
              .whereType<String>()
              .toList()
        : const <String>[];

    return CompositeSubscriptionModel(
      id: _parseId(json['id']),
      baseSubscriptionId: _parseId(json['base_subscription_id']) ?? '',
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      priceOverride: _parseInt(json['price_override']),
      rangeMonthOverride: _parseInt(json['range_month_override']),
      maxUsers: _parseInt(json['max_users']),
      maxCollaborators: _parseInt(json['max_collaborators']),
      modules: SubscriptionModule.parseList(json['modules']),
      validFrom: _parseDate(json['valid_from']),
      validUntil: _parseDate(json['valid_until']),
      maxRedemptions: _parseInt(json['max_redemptions']),
      isActive: json['is_active'] != false,
      internalNotes: (json['internal_notes'] ?? '') as String,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      base: base,
      companyIds: companyIds,
    );
  }

  /// Columnas de la tabla (sin id, joins ni campos de auditoría).
  /// Los nulos se envían explícitamente para poder quitar un límite.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'base_subscription_id': baseSubscriptionId,
    'title': title,
    'description': description,
    'discount': discount,
    'price_override': priceOverride,
    'range_month_override': rangeMonthOverride,
    'max_users': maxUsers,
    'max_collaborators': maxCollaborators,
    'modules': SubscriptionModule.toKeys(modules),
    if (validFrom != null) 'valid_from': validFrom!.toIso8601String(),
    'valid_until': validUntil?.toIso8601String(),
    'max_redemptions': maxRedemptions,
    'is_active': isActive,
    'internal_notes': internalNotes,
  };

  /// Para caché local (Hive): incluye id y plan base.
  Map<String, dynamic> toCacheJson() => <String, dynamic>{
    ...toJson(),
    if (id != null) 'id': id,
    if (base != null) 'base': base!.toJson(),
  };
}
