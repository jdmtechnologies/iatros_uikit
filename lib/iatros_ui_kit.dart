// =============================================================================
// Iatros UI Kit - Archivo principal con facade y exports
// =============================================================================

import 'package:iatros_uikit/utils/index_util.dart';
import 'package:iatros_uikit/models/index.dart';
import 'package:iatros_uikit/widgets/index_widget.dart';

// Models y tipos (para uso externo)
export 'models/index.dart';
export 'models/input_type.dart';
export 'models/blood_type.dart';
export 'models/city_model.dart';
export 'models/user_model.dart';
export 'models/gender_type.dart';
export 'models/country_model.dart';
export 'models/ethnicity_type.dart';
export 'models/department_model.dart';
export 'models/user_record_model.dart';
export 'models/announcement_model.dart';
export 'models/biological_sex_type.dart';
export 'models/disability_category.dart';
export 'models/discount_codes_model.dart';
export 'models/gender_identity_type.dart';
export 'models/medical_specialization.dart';
export 'models/suscription_settings_model.dart';
export 'models/health_administrators_model.dart';
export 'models/company_response_model.dart';

// Extensiones
export 'extension/context_extension.dart';
export 'extensions/string_extension.dart';

// Enums
export 'enum/email_type.dart';
export 'enum/company_validation_status.dart';
export 'enum/company_response_status.dart';

// Utils (colores, tema, estilos, helpers)
export 'utils/spacing.dart';
export 'utils/ui_color.dart';
export 'utils/app_theme.dart';
export 'utils/text_style.dart';
export 'utils/ui_helpers.dart';
export 'utils/index_util.dart';
export 'utils/loading_overlay.dart';
export 'utils/custom_show_dialog.dart';

// Widgets
export 'widgets/index_widget.dart';
export 'widgets/dropdown_widget.dart';
export 'widgets/base_card_widget.dart';
export 'widgets/text_input_widget.dart';
export 'widgets/icon_button_widget.dart';
export 'widgets/iatros_logo_widget.dart';
export 'widgets/image_button_widget.dart';
export 'widgets/password_input_widget.dart';
export 'widgets/checkbox_input_widget.dart';
export 'widgets/primary_button_widget.dart';
export 'widgets/gender_selector_widget.dart';
export 'widgets/secondary_button_widget.dart';
export 'widgets/time_picker_input_widget.dart';
export 'widgets/date_picker_input_widget.dart';
export 'widgets/file_picker_input_widget.dart';
export 'widgets/glassmorphism_card_widget.dart';
export 'widgets/image_picker_input_widget.dart';
export 'widgets/medical_background_widget.dart';
export 'widgets/background_example_widget.dart';
export 'widgets/blood_type_selector_widget.dart';
export 'widgets/multi_select_dropdown_widget.dart';
export 'widgets/identification_selector_widget.dart';
export 'widgets/simple_medical_background_widget.dart';

abstract class IatrosUi {
  IatrosUi._();

  static final util = Util();
  static final model = Models();
  static final widget = UiWidget();
}
