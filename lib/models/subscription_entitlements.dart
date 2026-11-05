import 'package:iatros_uikit/enum/subscription_module.dart';
import 'package:iatros_uikit/enum/subscription_type.dart';
import 'package:iatros_uikit/models/composite_subscription_model.dart';
import 'package:iatros_uikit/models/suscription_settings_model.dart';

/// Permisos efectivos de una suscripción: límites de miembros y módulos.
///
/// Orden de resolución:
/// 1. Compuesta (si el pago tiene una): sus límites por rol y sus módulos
///    (si la lista está vacía, los del plan base).
/// 2. Plan base con `entitlementsConfigured`: `maxMembers` y `modules` de BD.
/// 3. Respaldo: los valores fijos que la app usaba antes de que existieran
///    esas columnas, según `subscriptionType`. Sin plan → nada.
class SubscriptionEntitlements {
  /// Máximo total de miembros (incluye al dueño). `null` = sin límite.
  /// Solo aplica a planes base; en compuestas se usan [maxUsers] y
  /// [maxCollaborators].
  final int? maxMembers;

  /// Máximo de DOCTOR + OWNER. `null` = sin límite.
  final int? maxUsers;

  /// Máximo de SECRETARIAT, PHARMACY_MANAGER, etc. `null` = sin límite.
  final int? maxCollaborators;

  final Set<SubscriptionModule> modules;

  /// true si los límites vienen de una suscripción compuesta.
  final bool isComposite;

  /// false cuando no hay plan reconocible (pago viejo sin tipo): no se puede
  /// agregar a nadie, igual que antes.
  final bool hasPlan;

  const SubscriptionEntitlements({
    required this.maxMembers,
    required this.maxUsers,
    required this.maxCollaborators,
    required this.modules,
    required this.isComposite,
    required this.hasPlan,
  });

  static const none = SubscriptionEntitlements(
    maxMembers: 0,
    maxUsers: 0,
    maxCollaborators: 0,
    modules: <SubscriptionModule>{},
    isComposite: false,
    hasPlan: false,
  );

  bool hasModule(SubscriptionModule m) => modules.contains(m);

  factory SubscriptionEntitlements.resolve({
    SuscriptionSettingsModel? base,
    CompositeSubscriptionModel? composite,
  }) {
    final baseEnt = _fromBase(base ?? composite?.base);
    if (composite == null) return baseEnt;

    return SubscriptionEntitlements(
      maxMembers: null,
      maxUsers: composite.maxUsers,
      maxCollaborators: composite.maxCollaborators,
      modules: composite.modules.isNotEmpty ? composite.modules : baseEnt.modules,
      isComposite: true,
      hasPlan: true,
    );
  }

  static SubscriptionEntitlements _fromBase(SuscriptionSettingsModel? base) {
    if (base == null) return none;
    if (base.entitlementsConfigured) {
      return SubscriptionEntitlements(
        maxMembers: base.maxMembers,
        maxUsers: null,
        maxCollaborators: null,
        modules: base.modules,
        isComposite: false,
        hasPlan: true,
      );
    }
    return _legacy(base.subscriptionType);
  }

  /// Valores que estaban fijos en company_members_page.dart y
  /// drawer_menu_permissions.dart. No cambiar: es la red de seguridad para
  /// planes que aún no tienen sus columnas configuradas.
  static SubscriptionEntitlements _legacy(SubscriptionType? type) {
    int? max;
    Set<SubscriptionModule> modules;
    switch (type) {
      case SubscriptionType.professionalIndependent:
        max = 2;
        modules = {SubscriptionModule.saraIa};
      case SubscriptionType.ipsEssential:
        max = 6;
        modules = {SubscriptionModule.saraIa};
      case SubscriptionType.ipsAdvanced:
        max = 16;
        modules = {SubscriptionModule.saraIa, SubscriptionModule.pharmacy};
      case SubscriptionType.ipsInstitutional:
        max = null;
        modules = {SubscriptionModule.saraIa, SubscriptionModule.pharmacy};
      case null:
        return none;
    }
    return SubscriptionEntitlements(
      maxMembers: max,
      maxUsers: null,
      maxCollaborators: null,
      modules: modules,
      isComposite: false,
      hasPlan: true,
    );
  }

  /// ¿Se puede agregar un miembro más con este rol?
  ///
  /// [isDoctorRole]: true para DOCTOR/OWNER. [doctorCount] y
  /// [collaboratorCount] son los miembros actuales de cada grupo.
  bool canAddMember({
    required bool isDoctorRole,
    required int doctorCount,
    required int collaboratorCount,
  }) {
    if (!hasPlan) return false;
    if (isComposite) {
      final limit = isDoctorRole ? maxUsers : maxCollaborators;
      final current = isDoctorRole ? doctorCount : collaboratorCount;
      return limit == null || current < limit;
    }
    final total = doctorCount + collaboratorCount;
    return maxMembers == null || total < maxMembers!;
  }

  /// ¿Queda cupo para algún rol? (para habilitar los botones de agregar).
  bool canAddAnyMember({required int doctorCount, required int collaboratorCount}) =>
      canAddMember(isDoctorRole: true, doctorCount: doctorCount, collaboratorCount: collaboratorCount) ||
      canAddMember(isDoctorRole: false, doctorCount: doctorCount, collaboratorCount: collaboratorCount);
}
