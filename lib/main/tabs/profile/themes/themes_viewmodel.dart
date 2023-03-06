import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../../services/theme_switcher_service.dart';

class ThemesViewModel extends BaseViewModel {
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();

  void onThemeTapped(int index) async {
    await _themeSwitcherService.setColorTheme(index);
  }

  bool isDarkMode(BuildContext context) =>
      _themeSwitcherService.getIsDarkMode(context);
}
