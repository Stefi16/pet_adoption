import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/app/app.locator.dart';
import 'package:pet_adoption/models/animal_age.dart';
import 'package:pet_adoption/utils/enums.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:pet_adoption/utils/setup_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/image_upload_service.dart';

const keyYears = 'years';
const keyMonths = 'months';

class AddNewAdoptionViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final ImageUploaderService _imageUploaderService =
      locator<ImageUploaderService>();

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _breedController = TextEditingController();
  TextEditingController get breedController => _breedController;

  final TextEditingController _countryController = TextEditingController();
  TextEditingController get countryController => _countryController;

  final TextEditingController _cityController = TextEditingController();
  TextEditingController get cityController => _cityController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  AnimalAge? _ageResult;
  AnimalAge? get ageResult => _ageResult;
  set _setAgeResult(AnimalAge newAge) {
    _ageResult = newAge;
    notifyListeners();
  }

  AnimalGender? _chosenGender;
  AnimalGender? get chosenGender => _chosenGender;
  set _setNewValue(AnimalGender? newGender) {
    if (_chosenGender != newGender) {
      _chosenGender = newGender;
      notifyListeners();
    }
  }

  AnimalType? _chosenType;
  AnimalType? get chosenType => _chosenType;
  set _setNewAnimalTypeValue(AnimalType? animalType) {
    if (_chosenType != animalType) {
      _chosenType = animalType;
      notifyListeners();
    }
  }

  bool _hasNameError = false;
  bool get hasNameError => _hasNameError;
  set _setHasNameError(bool hasNameError) {
    if (_hasNameError != hasNameError) {
      _hasNameError = hasNameError;
      notifyListeners();
    }
  }

  bool _hasGenderError = false;
  bool get hasGenderError => _hasGenderError;
  set _setHasGenderError(bool hasGenderError) {
    if (_hasGenderError != hasGenderError) {
      _hasGenderError = hasGenderError;
      notifyListeners();
    }
  }

  bool _hasAnimalTypeError = false;
  bool get hasAnimalTypeError => _hasAnimalTypeError;
  set _setHasAnimalTypeError(bool hasAnimalTypeError) {
    if (_hasAnimalTypeError != hasAnimalTypeError) {
      _hasAnimalTypeError = hasAnimalTypeError;
      notifyListeners();
    }
  }

  bool _hasAgeError = false;
  bool get hasAgeError => _hasAgeError;
  set _setHasAgeError(bool hasAgeError) {
    if (_hasAgeError != hasAgeError) {
      _hasAgeError = hasAgeError;
      notifyListeners();
    }
  }

  bool _hasCountryError = false;
  bool get hasCountryError => _hasCountryError;
  set _setHasCountryError(bool hasCountryError) {
    if (_hasCountryError != hasCountryError) {
      _hasCountryError = hasCountryError;
      notifyListeners();
    }
  }

  bool _hasCityError = false;
  bool get hasCityError => _hasCityError;
  set _setHasCityError(bool hasCityError) {
    if (_hasCityError != hasCityError) {
      _hasCityError = hasCityError;
      notifyListeners();
    }
  }

  bool _hasDescriptionError = false;
  bool get hasDescriptionError => _hasDescriptionError;
  set _setHasDescriptionError(bool hasDescriptionError) {
    if (_hasDescriptionError != hasDescriptionError) {
      _hasDescriptionError = hasDescriptionError;
      notifyListeners();
    }
  }

  void chooseGender(AnimalGender? newValue) => _setNewValue = newValue;

  void chooseType(AnimalType? newValue) => _setNewAnimalTypeValue = newValue;

  void setYearsAndMonths(Map<String, int?>? result) {
    final int? months = result?[keyMonths];
    final int? years = result?[keyYears];

    if (months != null && years != null) {
      _setAgeResult = AnimalAge(months: months, years: years);
    }
  }

  Future<DialogResponse?> showAgeDialog() async {
    return await _dialogService.showCustomDialog(
      variant: DialogType.chooseAge,
      barrierDismissible: true,
    );
  }

  String getProperText(AppLocalizations text) {
    if (_ageResult == null) {
      return text.chooseAge;
    }

    final years = _ageResult?.years;
    final months = _ageResult?.months;

    if (years != null && months != null) {
      return '$years ${text.years[0]}. $months ${text.months[0]}.';
    }

    if (years != null) {
      return '$years ${text.years[0]}.';
    }

    return '$years ${text.months[0]}.';
  }

  String getAnimalTypeName(AnimalType type) {
    final text = AppLocalizations.of(
      StackedService.navigatorKey!.currentContext!,
    )!;

    switch (type) {
      case AnimalType.cat:
        return text.cat;
      case AnimalType.dog:
        return text.dog;
      case AnimalType.bird:
        return text.bird;
      case AnimalType.other:
        return text.other;
    }
  }

  void uploadPhoto(BuildContext context) async {
    final ImageUploadData result =
        await _imageUploaderService.showImagePickerModal(context);

    if (result.imageBytes.isEmpty || result.imageName.isEmpty) {
      return;
    }

    final compressedImage = await _imageUploaderService.compressBytes(
      result.imageBytes,
    );

    notifyListeners();
  }

  void publishAdoption() {
    _validateAll();

    if (_hasFormError()) {
      return;
    }
  }

  void _validateName() {
    final name = nameController.text.removeWhiteSpaces();
    _setHasNameError = name.isEmpty || name.length < 2;
  }

  void _validateGender() => _setHasGenderError = _chosenGender == null;

  void _validateAnimalType() => _setHasAnimalTypeError = _chosenType == null;

  void _validateAnimalAge() => _setHasAgeError = _ageResult == null;

  void _validateCountry() {
    final country = countryController.text.removeWhiteSpaces();
    _setHasCountryError = country.isEmpty || country.length < 3;
  }

  void _validateCity() {
    final city = cityController.text.removeWhiteSpaces();
    _setHasCityError = city.isEmpty || city.length < 2;
  }

  void _validateDescription() {
    final description = descriptionController.text.removeWhiteSpaces();
    _setHasNameError = description.isEmpty || description.length < 10;
  }

  void _validateAll() {
    _validateName();
    _validateGender();
    _validateAnimalType();
    _validateAnimalAge();
    _validateCountry();
    _validateCity();
    _validateDescription();
  }

  bool _hasFormError() =>
      _hasGenderError ||
      _hasNameError ||
      _hasAgeError ||
      _hasAnimalTypeError ||
      _hasCityError ||
      _hasCountryError ||
      _hasDescriptionError;
}
