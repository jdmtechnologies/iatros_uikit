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
  contracts('contracts'),
  informedConsents('informed_consents'),
  documents('documents'),
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

  /// Se guardó la "Configuración de Disponibilidad" de un médico (horarios
  /// y duración de consulta).
  doctorAvailabilitySaved(
    'doctor_availability_saved',
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

  /// Se creó una empresa ("Crear empresa").
  companyCreated('company_created', IatrosEventCategory.account),

  /// Se guardaron cambios de una empresa (nombre, NIT, logo...).
  companyUpdated('company_updated', IatrosEventCategory.account),

  /// Se guardó la "Configuración de empresa" (companies_settings).
  companySettingsSaved('company_settings_saved', IatrosEventCategory.account),

  /// Se creó un contrato ("Agregar contrato").
  contractCreated('contract_created', IatrosEventCategory.contracts),

  /// Se guardó la edición de un contrato ("Editar contrato").
  contractUpdated('contract_updated', IatrosEventCategory.contracts),

  /// Se editó un precio (servicio) individual de un contrato.
  contractPriceUpdated(
    'contract_price_updated',
    IatrosEventCategory.contracts,
  ),

  /// Se eliminó un precio (servicio) individual de un contrato.
  contractPriceDeleted(
    'contract_price_deleted',
    IatrosEventCategory.contracts,
  ),

  /// Se eliminó un contrato completo ("Eliminar todo").
  contractDeleted('contract_deleted', IatrosEventCategory.contracts),

  /// Se actualizó un contrato desactualizado (botón "Actualizar").
  contractOutdatedUpdated(
    'contract_outdated_updated',
    IatrosEventCategory.contracts,
  ),

  /// Se creó un consentimiento informado en "Configuración de empresa".
  informedConsentCreated(
    'informed_consent_created',
    IatrosEventCategory.informedConsents,
  ),

  /// Se editó un consentimiento informado.
  informedConsentUpdated(
    'informed_consent_updated',
    IatrosEventCategory.informedConsents,
  ),

  /// Se desactivó ("eliminó") un consentimiento informado.
  informedConsentDeactivated(
    'informed_consent_deactivated',
    IatrosEventCategory.informedConsents,
  ),

  /// Se generó el PDF de un consentimiento para un paciente.
  informedConsentGenerated(
    'informed_consent_generated',
    IatrosEventCategory.informedConsents,
  ),

  /// Se adjuntó el PDF de un consentimiento a los documentos de la consulta.
  informedConsentAttached(
    'informed_consent_attached',
    IatrosEventCategory.informedConsents,
  ),

  /// El médico generó el QR para que el paciente firme en su celular.
  informedConsentSigningStarted(
    'informed_consent_signing_started',
    IatrosEventCategory.informedConsents,
  ),

  /// El paciente firmó el consentimiento en su celular.
  informedConsentSignedByPatient(
    'informed_consent_signed_by_patient',
    IatrosEventCategory.informedConsents,
  ),

  /// La app del médico recibió el PDF firmado y lo adjuntó a la consulta.
  informedConsentSignedReceived(
    'informed_consent_signed_received',
    IatrosEventCategory.informedConsents,
  ),

  /// Se agregó un documento en la pestaña "Documentos" de la consulta.
  documentAdded('document_added', IatrosEventCategory.documents),

  /// Se descargó un PDF desde la vista previa ("Descargar").
  pdfDownloaded('pdf_downloaded', IatrosEventCategory.documents),

  /// El médico subió su firma en "Editar mi perfil".
  doctorSignatureUploaded(
    'doctor_signature_uploaded',
    IatrosEventCategory.account,
  ),

  /// El paciente escaneó el QR y abrió la página para firmar el
  /// consentimiento.
  informedConsentQrScanned(
    'informed_consent_qr_scanned',
    IatrosEventCategory.informedConsents,
  ),

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
