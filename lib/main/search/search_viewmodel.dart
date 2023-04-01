import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/main/tabs/adoption/base_adoption_viewmodel.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/animal_adoption.dart';

class SearchViewModel extends BaseAdoptionViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final FocusNode _searchFieldFocusNode = FocusNode();
  FocusNode get searchFieldFocusNode => _searchFieldFocusNode;

  final TextEditingController _searchTextController = TextEditingController();
  TextEditingController get searchTextController => _searchTextController;

  List<AnimalAdoption> _searchResults = [];
  List<AnimalAdoption> get searchResults => _searchResults;
  set _setSearchResults(List<AnimalAdoption> value) {
    _searchResults = value;
    notifyListeners();
  }

  bool _shouldShowDescription = false;
  bool get shouldShowDescription => _searchTextController.text.length <= 1;
  set _setShouldShowDescription(bool value) {
    if (value != _showClearIcon) {
      _shouldShowDescription = value;
      notifyListeners();
    }
  }

  bool _showClearIcon = false;
  bool get showClearIcon => _showClearIcon;
  set _setShowClearIcon(bool value) {
    if (value != _showClearIcon) {
      _showClearIcon = value;
      notifyListeners();
    }
  }

  @override
  void init() {
    super.init();
    _searchFieldFocusNode.requestFocus();
    _searchTextController.addListener(_textControllerListener);
  }

  void _textControllerListener() {
    final controllerText = _searchTextController.text;

    if (controllerText.isNotEmpty) {
      _setShowClearIcon = true;
    } else {
      _setShowClearIcon = false;
    }
  }

  void onChange(String value) {
    _setSearchResults = [];

    if (value.length < 2) {
      _setShouldShowDescription = true;
      return;
    }

    final List<AnimalAdoption> result = _searchByName();
    result.addAll(_searchByDescription());
    _setSearchResults = _removeRepeatingAdoptions(result);
    _setShouldShowDescription = false;
  }

  @override
  void dispose() {
    _searchTextController.removeListener(_textControllerListener);
    _searchTextController.dispose();
    _searchFieldFocusNode.dispose();
    super.dispose();
  }

  void goBack() => _navigationService.back();

  void clearText() {
    _searchTextController.clear();
  }

  void goToAdoptionDetailsPage(AnimalAdoption adoption) async {
    await _navigationService.navigateTo(
      Routes.adoptionDetailsView,
      arguments: AdoptionDetailsViewArguments(
        adoption: adoption,
      ),
    );
  }

  List<AnimalAdoption> _searchByName() {
    final List<AnimalAdoption> result = [];
    final String searchValue = _searchTextController.text;

    result.addAll(
      allAdoptions.where(
        (adoption) => adoption.animalName == searchValue,
      ),
    );

    result.addAll(
      allAdoptions.where(
        (adoption) => adoption.animalName.contains(
          searchValue.removeWhiteSpaces(),
        ),
      ),
    );

    for (final adoption in allAdoptions) {
      final wordsInName = adoption.animalName.split(' ');

      if (wordsInName.length == 1 || wordsInName.isEmpty) {
        continue;
      }

      for (final word in wordsInName) {
        final isPresent = word.removeWhiteSpaces().contains(
              searchValue.removeWhiteSpaces(),
            );

        if (isPresent) {
          result.add(adoption);
        }
      }
    }

    return result;
  }

  List<AnimalAdoption> _searchByDescription() {
    final List<AnimalAdoption> result = [];
    final String searchValue = _searchTextController.text;

    result.addAll(
      allAdoptions.where(
        (adoption) => adoption.description == searchValue,
      ),
    );

    result.addAll(
      allAdoptions.where(
        (adoption) => adoption.description.contains(
          searchValue.removeWhiteSpaces(),
        ),
      ),
    );

    for (final adoption in allAdoptions) {
      final wordsInName = adoption.description.split(' ');

      if (wordsInName.length == 1 || wordsInName.isEmpty) {
        continue;
      }

      for (final word in wordsInName) {
        final isPresent = word.removeWhiteSpaces().contains(
              searchValue.removeWhiteSpaces(),
            );

        if (isPresent) {
          result.add(adoption);
        }
      }
    }

    return result;
  }

  List<AnimalAdoption> _removeRepeatingAdoptions(
    List<AnimalAdoption> adoptions,
  ) {
    final List<AnimalAdoption> result = [];

    for (final adoption in adoptions) {
      if (!_doesNotContainAnimalAdoption(adoption, adoptions)) {
        result.add(adoption);
      }
    }

    return result;
  }

  bool _doesNotContainAnimalAdoption(AnimalAdoption comparingAdoption,
      List<AnimalAdoption> adoptionsToCompare) {
    return adoptionsToCompare
        .where((adoption) =>
            comparingAdoption.adoptionId == comparingAdoption.adoptionId)
        .isEmpty;
  }

  @override
  void refreshChildren() {
    notifyListeners();
  }
}
