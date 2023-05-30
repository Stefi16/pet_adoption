import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/animal_adoption.dart';
import '../../../services/database_service.dart';

abstract class BaseAdoptionViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  List<AnimalAdoption> favouriteAdoptions = [];

  List<AnimalAdoption> get allAdoptions {
    final allAdoptions = _databaseService.animalAdoptions;

    allAdoptions.sort(
      (a, b) => b.datePublished!.compareTo(a.datePublished!),
    );

    allAdoptions.removeWhere(
      (adoption) => !adoption.isApproved,
    );

    return allAdoptions;
  }

  late StreamSubscription<List<AnimalAdoption>> _streamSubscription;

  void init() {
    favouriteAdoptions.addAll(
      getFavouriteAdoptions(),
    );

    _streamSubscription = _databaseService.getAdoptionsStream().listen(
          _refreshedAdoptions,
        );
  }

  void _refreshedAdoptions(List<AnimalAdoption> animalAdoptions) {
    _databaseService.animalAdoptions.clear();
    _databaseService.animalAdoptions.addAll(animalAdoptions);
    refreshChildren();
  }

  void refreshChildren();

  bool isFavourite(AnimalAdoption adoption) {
    return favouriteAdoptions
        .where((fav) => fav.adoptionId == adoption.adoptionId)
        .isNotEmpty;
  }

  void toggleFavourites(AnimalAdoption adoption) {
    final currentUser = _databaseService.getCurrentUser();
    final userFavs = currentUser.favouritePosts;

    if (userFavs.contains(adoption.adoptionId)) {
      currentUser.favouritePosts.remove(adoption.adoptionId);
    } else {
      currentUser.favouritePosts.add(adoption.adoptionId);
    }

    favouriteAdoptions = getFavouriteAdoptions();
    _databaseService.addUser(currentUser);
    notifyListeners();
  }

  List<AnimalAdoption> getFavouriteAdoptions() {
    final currentUserFavourites =
        _databaseService.getCurrentUser().favouritePosts;
    final List<AnimalAdoption> result = [];

    for (final fav in currentUserFavourites) {
      final matchingAdoption = allAdoptions.where(
        (adoption) => adoption.adoptionId == fav,
      );

      if (matchingAdoption.isEmpty) {
        continue;
      }

      result.add(matchingAdoption.first);
    }

    return result;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
