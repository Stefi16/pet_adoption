import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/main/tabs/adoption/base_adoption_viewmodel.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/app.locator.dart';
import '../../../models/animal_adoption.dart';
import '../../../utils/enums.dart';

const String _favouriteCategory = 'Favourite';

class AdoptionViewModel extends BaseAdoptionViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final List<String> sortingCategories = [];

  List<AnimalAdoption> adoptions = [];

  int _currentIndex = -1;
  int get currentIndex => _currentIndex;
  set _setCurrentIndex(int index) {
    _currentIndex = index;
    _filterAdoptions();
    notifyListeners();
  }

  @override
  void init() {
    super.init();
    adoptions = List.from(allAdoptions);

    _initSortingCategories();
  }

  void goToAdoptionDetailsPage(AnimalAdoption adoption) async {
    await _navigationService.navigateTo(
      Routes.adoptionDetailsView,
      arguments: AdoptionDetailsViewArguments(
        adoption: adoption,
      ),
    );

    favouriteAdoptions = getFavouriteAdoptions();
    notifyListeners();
  }

  void _initSortingCategories() {
    sortingCategories.add(_favouriteCategory);
    sortingCategories.addAll(
      List.generate(
        AnimalType.values.length,
        (index) {
          final currentType = AnimalType.values.elementAt(index);
          return currentType.name;
        },
      ),
    );
  }

  AnimalType getAnimalTypeFromName(String name) {
    return AnimalType.values
        .where(
          (element) => element.name == name,
        )
        .first;
  }

  @override
  void toggleFavourites(AnimalAdoption adoption) {
    super.toggleFavourites(adoption);
    _filterAdoptions();
  }

  String getProperCategoryImage(int index) {
    if (index == 0) {
      return '';
    }

    return AnimalType.values.elementAt(index - 1).getAnimalTypeImageName();
  }

  String getProperText(int index) {
    if (index == 0) {
      final text = AppLocalizations.of(
        StackedService.navigatorKey!.currentContext!,
      )!;

      return text.favourites;
    }

    return AnimalType.values.elementAt(index - 1).getAnimalTypeName();
  }

  void changeCategory(int index) {
    if (currentIndex == index) {
      _setCurrentIndex = -1;
      return;
    }

    _setCurrentIndex = index;
  }

  void _filterAdoptions() {
    if (_currentIndex == -1) {
      adoptions = allAdoptions;
      return;
    }

    if (_currentIndex == 0) {
      adoptions = getFavouriteAdoptions();
      return;
    }

    adoptions = _getFilteredTypeAdoptions();
  }

  List<AnimalAdoption> _getFilteredTypeAdoptions() {
    final selectedType = AnimalType.values.elementAt(_currentIndex - 1);

    return allAdoptions
        .where(
          (adoption) => adoption.animalType == selectedType,
        )
        .toList();
  }

  void goToSearchScreen() => _navigationService.navigateTo(
        Routes.searchView,
      );

  void goToChatScreen() => _navigationService.navigateTo(Routes.chatView);

  @override
  void refreshChildren() {
    adoptions = allAdoptions;
    _filterAdoptions();
    notifyListeners();
  }
}
