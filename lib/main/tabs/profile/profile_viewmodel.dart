import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ProfileViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  late final AppUser _currentUser;

  void init() {
    _currentUser = _databaseService.getCurrentUser();
  }

  String getCurrentUserEmail() => _currentUser.email;

  String getCurrentUserUsername() => _currentUser.username ?? '';

  void onUserCardTap() {}
}
