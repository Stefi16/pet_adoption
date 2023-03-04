import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  set _setCurrentTabIndex(int index) {
    if (index != currentTabIndex) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  void changeTab(int index) => _setCurrentTabIndex = index;
}
