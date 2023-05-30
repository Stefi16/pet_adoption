import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../services/theme_switcher_service.dart';

class ThemesViewModel extends BaseViewModel {
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void onThemeTapped(int index) async {
    await _themeSwitcherService.setColorTheme(index);
  }

  bool isDarkMode(BuildContext context) {
    return _themeSwitcherService.getIsDarkMode(context);
  }

  void goBack() => _navigationService.back();

  bool isSelected(int index) {
    final currentIndex = _themeSwitcherService.currentColorTheme.value;

    return currentIndex == index;
  }
}
