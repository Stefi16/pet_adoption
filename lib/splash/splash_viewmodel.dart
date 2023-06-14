import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:pet_adoption/services/theme_switcher_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../services/auth_service.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();

  void init() async {
    final User? currentUser = _authService.currentUser;

    if (currentUser != null) {
      final appUser = await _databaseService.getUser(currentUser.uid);
      final adoptions = await _databaseService.getAdoptions();
      final users = await _databaseService.getUsers();
      final chats = await _databaseService.getChats();

      final currentTheme = _themeSwitcherService.currentColorTheme.value ?? 0;
      final currentDarkMode = _themeSwitcherService.isDarkMode.value ?? false;

      if (appUser.currentMobileTheme !=
          FlexScheme.values.elementAt(currentTheme)) {
        _themeSwitcherService.setColorTheme(appUser.currentMobileTheme.index);
      }

      if (appUser.isDarkMode != currentDarkMode) {
        _themeSwitcherService.setDarkTheme(appUser.isDarkMode);
      }

      chats.removeWhere(
        (chat) =>
            chat.senderId != currentUser.uid &&
            chat.posterId != currentUser.uid,
      );

      _databaseService.initDatabaseService(
        currentUser: appUser,
        animalAdoptions: adoptions,
        users: users,
        chats: chats,
      );

      Future.delayed(
        const Duration(seconds: 3),
        () {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              _navigationService.replaceWith(Routes.mainView);
            },
          );
        },
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigationService.replaceWith(Routes.loginView);
      });
    }
  }
}
