import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/app/app.locator.dart';
import 'package:pet_adoption/services/theme_switcher_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  set _setCurrentTabIndex(int index) {
    if (index != currentTabIndex) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  bool isDarkMode(BuildContext context) =>
      _themeSwitcherService.getIsDarkMode(context);
  void changeTab(int index) => _setCurrentTabIndex = index;
}
