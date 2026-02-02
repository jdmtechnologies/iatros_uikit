import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iatros_uikit/components/inputs/address_autocomplete_input.dart';
import 'package:iatros_uikit/components/inputs/specialization_selector.dart';
import 'package:iatros_uikit/models/blood_type.dart';
import 'package:iatros_uikit/models/gender_type.dart';
import 'package:iatros_uikit/models/input_type.dart';
import 'package:iatros_uikit/models/address_location_model.dart';
import 'package:iatros_uikit/models/medical_specialization.dart';
import 'package:iatros_uikit/models/place_details.dart';
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
  Widget medicalBackground({
    Key? key,
    required Widget child,
    bool showBotanicalElements = true,
  }) =>
      UiMedicalBackground(
        key: key,
        showBotanicalElements: showBotanicalElements,
        child: child,
      );

  Widget simpleMedicalBackground({
    Key? key,
    required Widget child,
    bool showElements = true,
  }) =>
      UiSimpleMedicalBackground(
        key: key,
        showElements: showElements,
        child: child,
      );

  Widget backgroundExample({Key? key}) => UiBackgroundExample(key: key);
}

class UiButtons {
  Widget primaryButton({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    double? width,
    double? height,
    bool isLoading = false,
    bool isDisabled = false,
  }) =>
      UiPrimaryButton(
        key: key,
        label: label,
        onPressed: onPressed,
        width: width,
        height: height,
        isLoading: isLoading,
        isDisabled: isDisabled,
      );

  Widget secondaryButton({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    double? width,
    double? height,
    bool isLoading = false,
    bool isDisabled = false,
  }) =>
      UiSecondaryButton(
        key: key,
        label: label,
        onPressed: onPressed,
        width: width,
        height: height,
        isLoading: isLoading,
        isDisabled: isDisabled,
      );

  Widget iconButton({
    Key? key,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Color? backgroundColor,
    Color? iconColor,
    double size = 24,
    String? tooltip,
  }) =>
      UiIconButton(
        key: key,
        icon: icon,
        onPressed: onPressed,
        isLoading: isLoading,
        isDisabled: isDisabled,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        size: size,
        tooltip: tooltip,
      );

  Widget imageButton({
    Key? key,
    required VoidCallback onTap,
    double size = 100,
    String? image,
    IconData? icon,
  }) =>
      UiImageButton(
        key: key,
        onTap: onTap,
        size: size,
        image: image ?? '',
        icon: icon,
      );
}

class UiCards {
  Widget baseCard({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double? elevation,
    BorderRadius? borderRadius,
    VoidCallback? onTap,
  }) =>
      UiBaseCard(
        key: key,
        padding: padding,
        margin: margin,
        backgroundColor: backgroundColor,
        elevation: elevation,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      );

  Widget glassmorphismCard({
    Key? key,
    required Widget child,
    double blur = 10.0,
    double opacity = 0.1,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    BoxBorder? border,
  }) =>
      UiGlassmorphismCard(
        key: key,
        blur: blur,
        opacity: opacity,
        padding: padding,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        border: border,
        child: child,
      );
}

class UiInputs {
  Widget textInput({
    Key? key,
    String? hint,
    String? label,
    int? maxLines,
    InputType type = InputType.dark,
    int? maxLength,
    bool isRequired = false,
    bool isReadOnly = false,
    bool obscureText = false,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      UiTextInput(
        key: key,
        hint: hint,
        label: label,
        maxLines: maxLines,
        type: type,
        maxLength: maxLength,
        isRequired: isRequired,
        isReadOnly: isReadOnly,
        obscureText: obscureText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        onTap: onTap,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
      );

  Widget passwordInput({
    Key? key,
    String? hint,
    String? label,
    InputType type = InputType.light,
    bool isRequired = false,
    String? errorText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) =>
      UiPasswordInput(
        key: key,
        hint: hint,
        label: label,
        type: type,
        isRequired: isRequired,
        errorText: errorText,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
      );

  Widget datePickerInput({
    Key? key,
    String? label,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    ValueNotifier<DateTime?>? selectedDateNotifier,
    ValueChanged<DateTime>? onDateSelected,
    bool isRequired = false,
    String? errorText,
    InputType type = InputType.dark,
  }) =>
      UiDatePickerInput(
        key: key,
        label: label,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate,
        selectedDateNotifier: selectedDateNotifier,
        onDateSelected: onDateSelected,
        isRequired: isRequired,
        errorText: errorText,
        type: type,
      );

  Widget identificationSelector({
    Key? key,
    ValueNotifier<String?>? selectedTypeNotifier,
    TextEditingController? numberController,
    ValueChanged<String?>? onTypeChanged,
    ValueChanged<String>? onNumberChanged,
    String? errorText,
    bool isRequired = false,
    InputType type = InputType.dark,
  }) =>
      UiIdentificationSelector(
        key: key,
        selectedTypeNotifier: selectedTypeNotifier,
        numberController: numberController,
        onTypeChanged: onTypeChanged,
        onNumberChanged: onNumberChanged,
        errorText: errorText,
        isRequired: isRequired,
        type: type,
      );

  Widget genderSelector({
    Key? key,
    ValueNotifier<Gender?>? selectedGenderNotifier,
    ValueChanged<Gender?>? onChanged,
    String? errorText,
    bool isRequired = false,
    InputType type = InputType.dark,
  }) =>
      UiGenderSelector(
        key: key,
        selectedGenderNotifier: selectedGenderNotifier,
        onChanged: onChanged,
        errorText: errorText,
        isRequired: isRequired,
        type: type,
      );

  Widget bloodTypeSelector({
    Key? key,
    ValueNotifier<BloodType?>? selectedBloodTypeNotifier,
    ValueChanged<BloodType?>? onChanged,
    String? errorText,
    bool isRequired = false,
    InputType type = InputType.dark,
  }) =>
      UiBloodTypeSelector(
        key: key,
        selectedBloodTypeNotifier: selectedBloodTypeNotifier,
        onChanged: onChanged,
        errorText: errorText,
        isRequired: isRequired,
        type: type,
      );

  Widget imagePickerInput({
    Key? key,
    String? label,
    String? hint,
    String? errorText,
    dynamic selectedImage,
    required ValueChanged<dynamic> onImageSelected,
    bool isRequired = false,
    double? maxWidth,
    double? maxHeight,
    InputType type = InputType.dark,
  }) =>
      UiImagePickerInput(
        key: key,
        label: label,
        hint: hint,
        errorText: errorText,
        selectedImage: selectedImage,
        onImageSelected: onImageSelected,
        isRequired: isRequired,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        type: type,
      );

  Widget filePickerInput({
    Key? key,
    String? label,
    String? hint,
    String? errorText,
    dynamic selectedFile,
    required ValueChanged<dynamic> onFileSelected,
    bool isRequired = false,
    List<String>? allowedExtensions,
    String? fileName,
  }) =>
      UiFilePickerInput(
        key: key,
        label: label,
        hint: hint,
        errorText: errorText,
        selectedFile: selectedFile,
        onFileSelected: onFileSelected,
        isRequired: isRequired,
        allowedExtensions: allowedExtensions,
        fileName: fileName,
      );

  Widget addressAutocompleteInput({
    Key? key,
    String? hint,
    String? label,
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    required ValueChanged<String> onAddressSelected,
    required Future<PlaceDetails?> Function(String) getPlaceDetails,
    ValueChanged<PlaceDetails>? onPlaceDetailsSelected,
    required Future<List<AddressLocationModel>> Function(String) searchAddressWeb,
    bool isRequired = false,
    InputType type = InputType.dark,
  }) =>
      AddressAutocompleteInput(
        key: key,
        hint: hint,
        label: label,
        errorText: errorText,
        initialValue: initialValue,
        controller: controller,
        onAddressSelected: onAddressSelected,
        getPlaceDetails: getPlaceDetails,
        onPlaceDetailsSelected: onPlaceDetailsSelected,
        searchAddressWeb: searchAddressWeb,
        isRequired: isRequired,
        type: type,
      );

  Widget multiSelectDropdown<T>({
    Key? key,
    String? label,
    String? hint,
    required List<T> options,
    required List<T> selectedItems,
    required String Function(T) displayText,
    required ValueChanged<List<T>> onChanged,
    bool isRequired = false,
    bool isMultiselect = true,
    String? errorText,
    Future<void> Function(String)? onSearch,
  }) =>
      UiMultiSelectDropdown<T>(
        key: key,
        label: label,
        hint: hint,
        options: options,
        selectedItems: selectedItems,
        displayText: displayText,
        onChanged: onChanged,
        isRequired: isRequired,
        isMultiselect: isMultiselect,
        errorText: errorText,
        onSearch: onSearch,
      );

  Widget specializationSelector({
    Key? key,
    String? selectedSpecialization,
    required ValueChanged<String?> onChanged,
    required List<MedicalSpecialization> initialList,
    String? errorText,
    bool isRequired = false,
    InputType type = InputType.dark,
  }) =>
      SpecializationSelector(
        key: key,
        selectedSpecialization: selectedSpecialization,
        onChanged: onChanged,
        initialList: initialList,
        errorText: errorText,
        isRequired: isRequired,
        type: type,
      );
}

class UiLogo {
  Widget iatrosLogo({
    Key? key,
    double? width,
    double? height,
    bool showText = true,
    Color? textColor,
    double? textSize,
  }) =>
      UiIatrosLogo(
        key: key,
        width: width,
        height: height,
        showText: showText,
        textColor: textColor,
        textSize: textSize,
      );

  Widget iatrosLogoVertical({
    Key? key,
    double? width,
    double? height,
  }) =>
      UiIatrosLogoVertical(
        key: key,
        width: width,
        height: height,
      );

  Widget iatrosLogoIcon({
    Key? key,
    double? size,
    Color? color,
  }) =>
      UiIatrosLogoIcon(
        key: key,
        size: size,
        color: color,
      );
}

class UiPopUp {
  Widget loadingOverlay({
    Key? key,
    required bool isLoading,
    required Widget child,
  }) =>
      LoadingOverlay(
        key: key,
        isLoading: isLoading,
        child: child,
      );
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
