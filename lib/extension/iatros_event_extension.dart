import 'package:iatros_uikit/enum/iatros_event_key.dart';

/// Nombres en español de los eventos de `iatros_events` para mostrarlos en
/// pantalla (app web y administración).
extension IatrosEventKeyExtension on IatrosEventKey {
  String get label => switch (this) {
    IatrosEventKey.aiAutoFillMedicalConsultation => 'Autocompletado con IA',
    IatrosEventKey.clinicalHistoryCreated => 'Historia clínica creada',
    IatrosEventKey.clinicalHistoryReopened => 'Historia clínica reabierta',
    IatrosEventKey.clinicalHistoryClarifyingNoteCreated =>
      'Nota aclaratoria creada',
    IatrosEventKey.clinicalHistoryOrdersUpdated =>
      'Órdenes de historia actualizadas',
    IatrosEventKey.emailSent => 'Correo enviado',
    IatrosEventKey.whatsappSent => 'WhatsApp enviado',
    IatrosEventKey.appointmentScheduled => 'Cita agendada',
    IatrosEventKey.doctorAvailabilitySaved => 'Disponibilidad guardada',
    IatrosEventKey.iatrosLogin => 'Inicio de sesión',
    IatrosEventKey.paymentBannerInProcessDismissed =>
      'Banner "Pago en proceso" cerrado',
    IatrosEventKey.paymentBannerNoSubscriptionDismissed =>
      'Banner "Suscripción expirada" cerrado',
    IatrosEventKey.paymentBannerDeclinedDismissed =>
      'Banner "Pago rechazado" cerrado',
    IatrosEventKey.subscriptionPaymentClicked => 'Clic en pagar suscripción',
    IatrosEventKey.clinicalHistoryPaymentClicked =>
      'Clic en pagar historia clínica',
    IatrosEventKey.userProfileUpdated => 'Perfil actualizado',
    IatrosEventKey.companySwitched => 'Cambio de empresa',
    IatrosEventKey.companyCreated => 'Empresa creada',
    IatrosEventKey.companyUpdated => 'Empresa actualizada',
    IatrosEventKey.companySettingsSaved => 'Configuración de empresa guardada',
    IatrosEventKey.contractCreated => 'Contrato creado',
    IatrosEventKey.contractUpdated => 'Contrato actualizado',
    IatrosEventKey.contractPriceUpdated => 'Precio de contrato actualizado',
    IatrosEventKey.contractPriceDeleted => 'Precio de contrato eliminado',
    IatrosEventKey.contractDeleted => 'Contrato eliminado',
    IatrosEventKey.contractOutdatedUpdated =>
      'Contrato desactualizado actualizado',
    IatrosEventKey.informedConsentCreated => 'Consentimiento creado',
    IatrosEventKey.informedConsentUpdated => 'Consentimiento editado',
    IatrosEventKey.informedConsentDeactivated => 'Consentimiento desactivado',
    IatrosEventKey.informedConsentGenerated => 'PDF de consentimiento generado',
    IatrosEventKey.informedConsentAttached => 'Consentimiento adjuntado',
    IatrosEventKey.informedConsentSigningStarted =>
      'QR de firma de consentimiento generado',
    IatrosEventKey.informedConsentQrScanned =>
      'QR de consentimiento escaneado',
    IatrosEventKey.informedConsentSignedByPatient =>
      'Consentimiento firmado por el paciente',
    IatrosEventKey.informedConsentSignedReceived =>
      'Consentimiento firmado recibido',
    IatrosEventKey.documentAdded => 'Documento agregado',
    IatrosEventKey.pdfDownloaded => 'PDF descargado',
    IatrosEventKey.doctorSignatureUploaded => 'Firma del médico subida',
    IatrosEventKey.error => 'Error',
    IatrosEventKey.uncaughtError => 'Error no capturado',
  };
}

extension IatrosEventCategoryExtension on IatrosEventCategory {
  String get label => switch (this) {
    IatrosEventCategory.ai => 'IA',
    IatrosEventCategory.clinicalHistory => 'Historia clínica',
    IatrosEventCategory.communication => 'Comunicación',
    IatrosEventCategory.scheduling => 'Agenda',
    IatrosEventCategory.auth => 'Autenticación',
    IatrosEventCategory.payments => 'Pagos',
    IatrosEventCategory.account => 'Cuenta',
    IatrosEventCategory.contracts => 'Contratos',
    IatrosEventCategory.informedConsents => 'Consentimientos informados',
    IatrosEventCategory.documents => 'Documentos',
    IatrosEventCategory.error => 'Errores',
  };
}

extension IatrosEventSeverityExtension on IatrosEventSeverity {
  String get label => switch (this) {
    IatrosEventSeverity.info => 'Info',
    IatrosEventSeverity.warning => 'Advertencia',
    IatrosEventSeverity.error => 'Error',
  };

  static IatrosEventSeverity fromValue(String? value) =>
      IatrosEventSeverity.values.firstWhere(
        (s) => s.value == value,
        orElse: () => IatrosEventSeverity.info,
      );
}

extension IatrosEventStatusExtension on IatrosEventStatus {
  String get label => switch (this) {
    IatrosEventStatus.success => 'Éxito',
    IatrosEventStatus.failure => 'Fallo',
  };

  static IatrosEventStatus fromValue(String? value) =>
      IatrosEventStatus.values.firstWhere(
        (s) => s.value == value,
        orElse: () => IatrosEventStatus.success,
      );
}

/// Nombre del evento; si el `event_key` no está en [IatrosEventKey] (ej. uno
/// nuevo que admin aún no conoce) se muestra tal cual.
String iatrosEventKeyLabel(String eventKey) =>
    IatrosEventKey.fromValue(eventKey)?.label ?? eventKey;

/// Nombre de la categoría; si no está en [IatrosEventCategory] se muestra tal
/// cual.
String iatrosEventCategoryLabel(String category) {
  for (final c in IatrosEventCategory.values) {
    if (c.value == category) return c.label;
  }
  return category;
}
