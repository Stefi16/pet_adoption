import 'dart:ui';

import 'package:pet_adoption/utils/enums.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/animal_age.dart';

extension Capitalize on String {
  String capitalizeFirstLetter() {
    return '${substring(0, 1).toUpperCase()}${substring(1)}';
  }
}

extension RemoveWhiteSpaces on String {
  String removeWhiteSpaces() {
    return replaceAll(' ', '');
  }
}

extension IsFemale on AnimalGender? {
  bool? isFemale() {
    if (this != null) {
      return AnimalGender.female == this;
    }
  }
}

extension AnimalTypeName on AnimalType {
  String getAnimalTypeName() {
    final text = AppLocalizations.of(
      StackedService.navigatorKey!.currentContext!,
    )!;

    switch (this) {
      case AnimalType.cat:
        return text.cat;
      case AnimalType.dog:
        return text.dog;
      case AnimalType.bird:
        return text.bird;
      case AnimalType.other:
        return text.other;
      case AnimalType.rabbit:
        return text.rabbit;
      case AnimalType.fish:
        return text.fish;
    }
  }
}

extension AnimalGenderName on AnimalGender {
  String getAnimalGenderName() {
    final text = AppLocalizations.of(
      StackedService.navigatorKey!.currentContext!,
    )!;

    switch (this) {
      case AnimalGender.female:
        return text.female;
      case AnimalGender.male:
        return text.male;
    }
  }
}

extension AnimalTypeImageName on AnimalType {
  String getAnimalTypeImageName() {
    switch (this) {
      case AnimalType.cat:
        return 'assets/pet_silhouettes/cat_silhouette.png';
      case AnimalType.dog:
        return 'assets/pet_silhouettes/dog_silhouette.png';
      case AnimalType.bird:
        return 'assets/pet_silhouettes/bird_silhouette.png';
      case AnimalType.other:
        return 'assets/pet_silhouettes/penguin_silhouette.png';
      case AnimalType.rabbit:
        return 'assets/pet_silhouettes/rabbit_silhouette.png';
      case AnimalType.fish:
        return 'assets/pet_silhouettes/fish_silhouette.png';
    }
  }
}

extension AnimalAgeName on AnimalAge? {
  String getAnimalAgeText([
    bool withTextForNull = false,
  ]) {
    final text = AppLocalizations.of(
      StackedService.navigatorKey!.currentContext!,
    )!;

    if (this == null) {
      return withTextForNull ? text.chooseAge : '';
    }

    final years = this?.years;
    final months = this?.months;

    if (years != null && months != null) {
      return '$years ${text.years[0]}. $months ${text.months[0]}.';
    }

    if (years != null) {
      return '$years ${text.years[0]}.';
    }

    return '$years ${text.months[0]}.';
  }
}
