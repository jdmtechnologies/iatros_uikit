/// Módulos que una suscripción puede habilitar.
///
/// El `key` es el valor guardado en las columnas `modules text[]` de
/// `subscriptions_settings` y `composite_subscription_configuration`
/// (ver iatros/supabase/sql/create_composite_subscription_configuration.sql).
enum SubscriptionModule {
  saraIa('sara_ia', 'Sara IA'),
  pharmacy('pharmacy', 'Farmacia');

  const SubscriptionModule(this.key, this.label);

  final String key;
  final String label;

  static SubscriptionModule? fromKey(String? key) {
    for (final m in SubscriptionModule.values) {
      if (m.key == key) return m;
    }
    return null;
  }

  /// Convierte una lista de Supabase (`text[]`) ignorando valores desconocidos.
  static Set<SubscriptionModule> parseList(dynamic raw) {
    if (raw is! List) return <SubscriptionModule>{};
    return raw
        .map((e) => fromKey(e?.toString()))
        .whereType<SubscriptionModule>()
        .toSet();
  }

  static List<String> toKeys(Iterable<SubscriptionModule> modules) =>
      modules.map((m) => m.key).toList();
}
