import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'themeModeKey';
const String _themeColorKey = 'themeColorKey';

class ThemeSwitcherService {
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
    _currentColorTheme.value = value;
  }

  void getColorTheme() async {
    final colorThemeIndex = _sharedPreferences.getInt(_themeColorKey);
    _currentColorTheme.value = colorThemeIndex;
  }

  Future<void> resetTheme() async {
    await _sharedPreferences.clear();
  }
}
