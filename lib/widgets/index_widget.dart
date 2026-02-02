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

class UiBackgrounds {
  Type get medicalBackground => UiMedicalBackground;
  Type get simpleMedicalBackground => UiSimpleMedicalBackground;
  Type get backgroundExample => UiBackgroundExample;
}

class UiButtons {
  Type get primaryButton => UiPrimaryButton;
  Type get secondaryButton => UiSecondaryButton;
  Type get iconButton => UiIconButton;
  Type get imageButton => UiImageButton;
}

class UiCards {
  Type get baseCard => UiBaseCard;
  Type get glassmorphismCard => UiGlassmorphismCard;
}

class UiInputs {
  Type get textInput => UiTextInput;
  Type get passwordInput => UiPasswordInput;
  Type get datePickerInput => UiDatePickerInput;
  Type get identificationSelector => UiIdentificationSelector;
  Type get genderSelector => UiGenderSelector;
  Type get bloodTypeSelector => UiBloodTypeSelector;
  Type get imagePickerInput => UiImagePickerInput;
  Type get filePickerInput => UiFilePickerInput;
  Type get multiSelectDropdown => UiMultiSelectDropdown;
}

class UiLogo {
  Type get iatrosLogo => UiIatrosLogo;
  Type get iatrosLogoVertical => UiIatrosLogoVertical;
  Type get iatrosLogoIcon => UiIatrosLogoIcon;
}

class UiPopUp {
  Type get loadingOverlay => LoadingOverlay;
}

/// Agrupa todos los widgets del paquete.
class UiWidget {
  UiWidget._();
  static final UiWidget _instance = UiWidget._();
  factory UiWidget() => _instance;

  UiBackgrounds backgrounds = UiBackgrounds();
  UiButtons buttons = UiButtons();
  UiCards cards = UiCards();
  UiInputs inputs = UiInputs();
  UiLogo logo = UiLogo();
  UiPopUp popUp = UiPopUp();
}
