// =============================================================================
// Iatros UI Kit - Archivo principal con facade y exports
// =============================================================================

import 'package:iatros_ui/utils/index_util.dart';
import 'package:iatros_ui/models/index.dart';
import 'package:iatros_ui/widgets/index_widget.dart';

// Models y tipos (para uso externo)
export 'models/input_type.dart';
export 'models/gender_type.dart';
export 'models/blood_type.dart';
export 'models/medical_specialization.dart';
export 'models/index.dart';

// Extensiones
export 'extension/context_extension.dart';

// Utils (colores, tema, estilos, helpers)
export 'utils/ui_color.dart';
export 'utils/app_theme.dart';
export 'utils/text_style.dart';
export 'utils/spacing.dart';
export 'utils/ui_helpers.dart';
export 'utils/loading_overlay.dart';
export 'utils/custom_show_dialog.dart';
export 'utils/index_util.dart';

// Widgets
export 'widgets/primary_button_widget.dart';
export 'widgets/secondary_button_widget.dart';
export 'widgets/icon_button_widget.dart';
export 'widgets/image_button_widget.dart';
export 'widgets/base_card_widget.dart';
export 'widgets/glassmorphism_card_widget.dart';
export 'widgets/text_input_widget.dart';
export 'widgets/password_input_widget.dart';
export 'widgets/date_picker_input_widget.dart';
export 'widgets/identification_selector_widget.dart';
export 'widgets/gender_selector_widget.dart';
export 'widgets/blood_type_selector_widget.dart';
export 'widgets/image_picker_input_widget.dart';
export 'widgets/file_picker_input_widget.dart';
export 'widgets/multi_select_dropdown_widget.dart';
export 'widgets/iatros_logo_widget.dart';
export 'widgets/medical_background_widget.dart';
export 'widgets/simple_medical_background_widget.dart';
export 'widgets/background_example_widget.dart';
export 'widgets/index_widget.dart';

/// Facade del paquete Iatros UI.
///
/// Uso en una app consumidora:
/// ```dart
/// import 'package:iatros_ui/iatros_ui.dart';
///
/// IatrosUi.util.color.primary
/// IatrosUi.util.theme.lightTheme
/// IatrosUi.util.textStyle.h1
/// IatrosUi.util.spacing.paddingMD
/// IatrosUi.util.helpers.verticalSpaceMD
/// IatrosUi.model
///
/// // Widgets por clase:
/// UiPrimaryButton(label: 'Guardar', onPressed: () {})
/// UiBaseCard(child: ...)
/// ```
abstract class IatrosUi {
  IatrosUi._();

  static final util = Util();
  static final model = Models();
  static final widget = UiWidget();
}
