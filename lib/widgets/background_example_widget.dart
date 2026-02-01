import 'package:flutter/material.dart';
import 'package:iatros_ui/utils/ui_color.dart';
import 'package:iatros_ui/utils/text_style.dart';
import 'package:iatros_ui/utils/spacing.dart';
import 'package:iatros_ui/utils/ui_helpers.dart';
import 'package:iatros_ui/widgets/base_card_widget.dart';
import 'package:iatros_ui/widgets/simple_medical_background_widget.dart';
import 'package:iatros_ui/widgets/medical_background_widget.dart';

class UiBackgroundExample extends StatelessWidget {
  const UiBackgroundExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Fondos Médicos'),
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingLG),
        child: Column(
          children: [
            UiBaseCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fondo Médico Simple',
                    style: AppTypography.h4,
                  ),
                  UIHelpers.verticalSpaceMD,
                  Text(
                    'Este es el fondo que se está usando actualmente en la aplicación.',
                    style: AppTypography.bodyMedium,
                  ),
                  UIHelpers.verticalSpaceLG,
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                      border: Border.all(color: AppColors.gray300),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMD),
                      child: UiSimpleMedicalBackground(
                        child: Center(
                          child: Text(
                            'Contenido de ejemplo',
                            style: AppTypography.h5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelpers.verticalSpaceLG,
            UiBaseCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fondo Médico Elaborado',
                    style: AppTypography.h4,
                  ),
                  UIHelpers.verticalSpaceMD,
                  Text(
                    'Este fondo incluye elementos botánicos más detallados y complejos.',
                    style: AppTypography.bodyMedium,
                  ),
                  UIHelpers.verticalSpaceLG,
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                      border: Border.all(color: AppColors.gray300),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMD),
                      child: UiMedicalBackground(
                        child: Center(
                          child: Text(
                            'Contenido de ejemplo',
                            style: AppTypography.h5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelpers.verticalSpaceLG,
            UiBaseCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paleta de Colores Médicos',
                    style: AppTypography.h4,
                  ),
                  UIHelpers.verticalSpaceMD,
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _ColorSwatch('Azul Médico', AppColors.medicalBlue),
                      _ColorSwatch('Verde Botánico', AppColors.botanicalGreen),
                      _ColorSwatch('Verde Hoja', AppColors.leafGreen),
                      _ColorSwatch('Turquesa', AppColors.turquoise),
                      _ColorSwatch('Coral', AppColors.coral),
                      _ColorSwatch('Melocotón', AppColors.peach),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorSwatch(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingSM,
        vertical: AppSpacing.paddingXS,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Text(
        name,
        style: AppTypography.caption.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
