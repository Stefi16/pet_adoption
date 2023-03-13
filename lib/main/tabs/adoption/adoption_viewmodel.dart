import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/animal_adoption.dart';
import '../../../services/database_service.dart';

class AdoptionViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  final List<AnimalAdoption> allAdoptions = [];

  AdoptionViewModel() {
    allAdoptions.addAll(_databaseService.animalAdoptions);
  }
}
