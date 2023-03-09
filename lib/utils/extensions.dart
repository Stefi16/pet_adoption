import 'package:pet_adoption/utils/enums.dart';

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
