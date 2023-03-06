import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UsernameDialogViewModel extends BaseViewModel {
  TextEditingController get usernameTextController => _usernameTextController;
  final TextEditingController _usernameTextController = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  FocusNode get usernameFocusNode => _usernameFocusNode;

  bool get hasUsernameError => _hasUsernameError;
  bool _hasUsernameError = false;
  set _setUsernameError(bool value) {
    if (_hasUsernameError != value) {
      _hasUsernameError = value;
      notifyListeners();
    }
  }

  void init() {
    _usernameFocusNode.requestFocus();
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      _setUsernameError = false;
      return;
    }

    validateUsername();
  }

  void validateUsername() {
    final username = usernameTextController.text;

    if (username.length > 3) {
      _setUsernameError = false;
      return;
    }

    _setUsernameError = true;
  }
}
