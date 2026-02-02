import 'package:iatros_uikit/widgets/primary_button_widget.dart';
import 'package:iatros_uikit/widgets/secondary_button_widget.dart';
import 'package:iatros_uikit/widgets/icon_button_widget.dart';
import 'package:iatros_uikit/widgets/image_button_widget.dart';
import 'package:iatros_uikit/widgets/base_card_widget.dart';
import 'package:iatros_uikit/widgets/glassmorphism_card_widget.dart';
import 'package:iatros_uikit/widgets/text_input_widget.dart';
import 'package:iatros_uikit/widgets/password_input_widget.dart';
import 'package:iatros_uikit/widgets/date_picker_input_widget.dart';
import 'package:iatros_uikit/widgets/identification_selector_widget.dart';
import 'package:iatros_uikit/widgets/gender_selector_widget.dart';
import 'package:iatros_uikit/widgets/blood_type_selector_widget.dart';
import 'package:iatros_uikit/widgets/image_picker_input_widget.dart';
import 'package:iatros_uikit/widgets/file_picker_input_widget.dart';
import 'package:iatros_uikit/widgets/multi_select_dropdown_widget.dart';
import 'package:iatros_uikit/widgets/iatros_logo_widget.dart';
import 'package:iatros_uikit/widgets/medical_background_widget.dart';
import 'package:iatros_uikit/widgets/simple_medical_background_widget.dart';
import 'package:iatros_uikit/widgets/background_example_widget.dart';
import 'package:iatros_uikit/utils/loading_overlay.dart';

/// Accessor de fondos: IatrosUi.widget.backgrounds.medicalBackground, etc.
class BackgroundsAccessor {
  Type get medicalBackground => UiMedicalBackground;
  Type get simpleMedicalBackground => UiSimpleMedicalBackground;
  Type get backgroundExample => UiBackgroundExample;
}

/// Accessor de botones: IatrosUi.widget.buttons.primaryButton, etc.
class ButtonsAccessor {
  Type get primaryButton => UiPrimaryButton;
  Type get secondaryButton => UiSecondaryButton;
  Type get iconButton => UiIconButton;
  Type get imageButton => UiImageButton;
}

/// Agrupa todos los widgets del paquete.
class UiWidget {
  UiWidget._();
  static final UiWidget _instance = UiWidget._();
  factory UiWidget() => _instance;

  static final BackgroundsAccessor _backgrounds = BackgroundsAccessor();
  static final ButtonsAccessor _buttons = ButtonsAccessor();

  /// Acceso a fondos: medicalBackground, simpleMedicalBackground, backgroundExample.
  BackgroundsAccessor get backgrounds => _backgrounds;

  /// Acceso a botones: primaryButton, secondaryButton, iconButton, imageButton.
  ButtonsAccessor get buttons => _buttons;

  // Buttons (legacy - use buttons.primaryButton)
  static Type get primaryButton => UiPrimaryButton;
  static Type get secondaryButton => UiSecondaryButton;
  static Type get iconButton => UiIconButton;
  static Type get imageButton => UiImageButton;

  // Cards
  static Type get baseCard => UiBaseCard;
  static Type get glassmorphismCard => UiGlassmorphismCard;

  // Inputs
  static Type get textInput => UiTextInput;
  static Type get passwordInput => UiPasswordInput;
  static Type get datePickerInput => UiDatePickerInput;
  static Type get identificationSelector => UiIdentificationSelector;
  static Type get genderSelector => UiGenderSelector;
  static Type get bloodTypeSelector => UiBloodTypeSelector;
  static Type get imagePickerInput => UiImagePickerInput;
  static Type get filePickerInput => UiFilePickerInput;
  static Type get multiSelectDropdown => UiMultiSelectDropdown;

  // Logo
  static Type get iatrosLogo => UiIatrosLogo;
  static Type get iatrosLogoVertical => UiIatrosLogoVertical;
  static Type get iatrosLogoIcon => UiIatrosLogoIcon;

  // Backgrounds
  static Type get medicalBackground => UiMedicalBackground;
  static Type get simpleMedicalBackground => UiSimpleMedicalBackground;
  static Type get backgroundExample => UiBackgroundExample;

  // Utils (widget)
  static Type get loadingOverlay => LoadingOverlay;
}
