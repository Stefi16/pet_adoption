import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app.locator.dart';

const String _themeModeKey = 'themeModeKey';
const String _themeColorKey = 'themeColorKey';

class ThemeSwitcherService {
  final DatabaseService _databaseService = locator<DatabaseService>();

  late final SharedPreferences _sharedPreferences;

  final ValueNotifier<bool?> _isDarkMode = ValueNotifier<bool?>(false);

  ValueNotifier<bool?> get isDarkMode => _isDarkMode;

  final ValueNotifier<int?> _currentColorTheme = ValueNotifier<int?>(null);

  ValueNotifier<int?> get currentColorTheme => _currentColorTheme;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    getIsDarkTheme();
    getColorTheme();
  }

  Future<void> setDarkTheme(bool value) async {
    await _sharedPreferences.setBool(_themeModeKey, value);

    final currentUser = _databaseService.getCurrentUser();
    currentUser.isDarkMode = value;
    await _databaseService.addUser(currentUser);

    _isDarkMode.value = value;
  }

  void getIsDarkTheme() async {
    final isDarkMode = _sharedPreferences.getBool(_themeModeKey);
    _isDarkMode.value = isDarkMode;
  }

  bool getIsDarkMode(BuildContext context) {
    final bool? isDarkMode = _isDarkMode.value;

    if (isDarkMode == null) {
      var brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      return isDarkMode;
    }

    return isDarkMode;
  }

  Future<void> setColorTheme(int value) async {
    await _sharedPreferences.setInt(_themeColorKey, value);

    final currentUser = _databaseService.getCurrentUser();
    currentUser.currentMobileTheme = FlexScheme.values.elementAt(value);
    await _databaseService.addUser(currentUser);

    _currentColorTheme.value = value;
  }

  void getColorTheme() async {
    final colorThemeIndex = _sharedPreferences.getInt(_themeColorKey);
    _currentColorTheme.value = colorThemeIndex;
  }

  Future<void> resetTheme() async {
    _currentColorTheme.value = FlexScheme.aquaBlue.index;
    _isDarkMode.value = false;

    await _sharedPreferences.clear();
  }
}
