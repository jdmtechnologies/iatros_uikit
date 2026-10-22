/// Área del negocio a la que pertenece un evento de `iatros_events`; sirve
/// para agrupar métricas sin tener que listar cada [IatrosEventKey].
enum IatrosEventCategory {
  ai('ai'),
  clinicalHistory('clinical_history'),
  communication('communication'),
  scheduling('scheduling'),
  auth('auth'),
  payments('payments'),
  account('account'),
  error('error');

  final String value;

  const IatrosEventCategory(this.value);
}

/// Gravedad de un evento (`severity` en `iatros_events`).
enum IatrosEventSeverity {
  info('info'),
  warning('warning'),
  error('error');

  final String value;

  const IatrosEventSeverity(this.value);
}

/// Resultado de la acción que registra el evento (`status` en
/// `iatros_events`), ej. un uso de IA que falló.
enum IatrosEventStatus {
  success('success'),
  failure('failure');

  final String value;

  const IatrosEventStatus(this.value);
}

/// Eventos importantes del negocio que se guardan en la tabla
/// `iatros_events` (`event_key`). [value] es lo que se guarda: no cambiarlo
/// una vez en producción, o las métricas históricas quedan partidas.
enum IatrosEventKey {
  /// Se usó la IA para autocompletar la consulta médica.
  aiAutoFillMedicalConsultation(
    'ai_auto_fill_medical_consultation',
    IatrosEventCategory.ai,
  ),

  /// Se creó (guardó) una historia clínica.
  clinicalHistoryCreated(
    'clinical_history_created',
    IatrosEventCategory.clinicalHistory,
  ),

  /// Se reabrió una historia clínica ya finalizada.
  clinicalHistoryReopened(
    'clinical_history_reopened',
    IatrosEventCategory.clinicalHistory,
  ),

  /// Se guardó una nota aclaratoria en una historia reabierta.
  clinicalHistoryClarifyingNoteCreated(
    'clinical_history_clarifying_note_created',
    IatrosEventCategory.clinicalHistory,
  ),

  /// Se guardaron órdenes (medicamentos, CUPS, incapacidad) en una historia
  /// reabierta.
  clinicalHistoryOrdersUpdated(
    'clinical_history_orders_updated',
    IatrosEventCategory.clinicalHistory,
  ),

  /// Se pidió al backend enviar un correo.
  emailSent('email_sent', IatrosEventCategory.communication),

  /// Se pidió al backend enviar un WhatsApp.
  whatsappSent('whatsapp_sent', IatrosEventCategory.communication),

  /// Se agendó una cita médica.
  appointmentScheduled(
    'appointment_scheduled',
    IatrosEventCategory.scheduling,
  ),

  /// Un usuario inició sesión (o lo intentó, con `status` failure).
  iatrosLogin('iatros_login', IatrosEventCategory.auth),

  /// Se quitó el banner amarillo de "Pago en proceso".
  paymentBannerInProcessDismissed(
    'payment_banner_in_process_dismissed',
    IatrosEventCategory.payments,
  ),

  /// Se quitó el banner rojo de "Suscripción expirada" (sin suscripción
  /// activa).
  paymentBannerNoSubscriptionDismissed(
    'payment_banner_no_subscription_dismissed',
    IatrosEventCategory.payments,
  ),

  /// Se quitó el banner rojo de "Pago rechazado".
  paymentBannerDeclinedDismissed(
    'payment_banner_declined_dismissed',
    IatrosEventCategory.payments,
  ),

  /// Se hizo clic en pagar una suscripción ("Empezar Ahora" de un plan).
  subscriptionPaymentClicked(
    'subscription_payment_clicked',
    IatrosEventCategory.payments,
  ),

  /// Se hizo clic en pagar una historia clínica ("Pagar ahora").
  clinicalHistoryPaymentClicked(
    'clinical_history_payment_clicked',
    IatrosEventCategory.payments,
  ),

  /// Se guardaron cambios en "Editar mi perfil".
  userProfileUpdated('user_profile_updated', IatrosEventCategory.account),

  /// El usuario cambió la empresa seleccionada.
  companySwitched('company_switched', IatrosEventCategory.account),

  /// Se guardaron cambios de una empresa (nombre, NIT, logo...).
  companyUpdated('company_updated', IatrosEventCategory.account),

  /// Se guardó la "Configuración de empresa" (companies_settings).
  companySettingsSaved('company_settings_saved', IatrosEventCategory.account),

  /// Error capturado en un `try/catch`.
  error('error', IatrosEventCategory.error),

  /// Error no capturado (Flutter o zona raíz).
  uncaughtError('uncaught_error', IatrosEventCategory.error);

  final String value;
  final IatrosEventCategory category;

  const IatrosEventKey(this.value, this.category);

  static IatrosEventKey? fromValue(String? value) {
    for (final key in values) {
      if (key.value == value) return key;
    }
    return null;
  }
}
