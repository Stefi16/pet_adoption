import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/app/app.locator.dart';
import 'package:pet_adoption/services/theme_switcher_service.dart';
import 'package:stacked/stacked.dart';

class MainAppViewModel extends BaseViewModel {
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();

  void init() {
    _themeSwitcherService.isDarkMode.addListener(
      _addThemeListener,
    );

    _themeSwitcherService.currentColorTheme.addListener(
      _addThemeListener,
    );
  }

  void _addThemeListener() {
    notifyListeners();
  }

  ThemeMode getCurrentThemeMode() {
    final isDarkMode = _themeSwitcherService.isDarkMode.value;

    if (isDarkMode == null) {
      return ThemeMode.system;
    }

    if (isDarkMode) {
      return ThemeMode.dark;
    }

    return ThemeMode.light;
  }

  FlexScheme getProperColorTheme() {
    final int? currentColorThemeValue =
        _themeSwitcherService.currentColorTheme.value;

    if (currentColorThemeValue == null) {
      return FlexScheme.aquaBlue;
    }

    return FlexScheme.values.elementAt(currentColorThemeValue);
  }

  @override
  void dispose() {
    _themeSwitcherService.isDarkMode.removeListener(
      _addThemeListener,
    );

    _themeSwitcherService.currentColorTheme.removeListener(
      _addThemeListener,
    );

    super.dispose();
  }
}
