import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../services/auth_service.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void init() async {
    final User? currentUser = _authService.currentUser;

    if (currentUser != null) {
      final appUser = await _databaseService.getUser(currentUser.uid);
      _databaseService.setCurrentUser(appUser);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigationService.replaceWith(Routes.mainView);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigationService.replaceWith(Routes.loginView);
      });
    }
  }
}
