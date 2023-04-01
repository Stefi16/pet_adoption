import 'package:email_validator/email_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

abstract class BaseAuthenticationViewModel extends BaseViewModel {
  FocusNode get passwordFocusNode => _passwordFocusNode;
  final FocusNode _passwordFocusNode = FocusNode();

  FocusNode get confirmPasswordFocusNode => _confirmPasswordFocusNode;
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final TextEditingController _emailTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;

  TextEditingController get passwordTextController => _passwordTextController;
  final TextEditingController _passwordTextController = TextEditingController();

  bool get shouldHidePassword => _shouldHidePassword;
  bool _shouldHidePassword = true;
  set _setShouldHidePassword(bool value) {
    if (_shouldHidePassword != value) {
      _shouldHidePassword = value;
      notifyListeners();
    }
  }

  bool get hasEmailError => _hasEmailError;
  bool _hasEmailError = false;
  set _setHasEmailError(bool value) {
    if (_hasEmailError != value) {
      _hasEmailError = value;
      notifyListeners();
    }
  }

  bool get hasPasswordError => _hasPasswordError;
  bool _hasPasswordError = false;
  set _setHasPasswordError(bool value) {
    if (_hasPasswordError != value) {
      _hasPasswordError = value;
      notifyListeners();
    }
  }

  bool get isLoading => _isLoading;
  bool _isLoading = false;
  set setIsLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  bool isRegister = false;

  bool hasTextFieldError();

  void toggleVisibility() => _setShouldHidePassword = !shouldHidePassword;

  void onEmailFocusChange(bool isFocused) {
    if (isFocused) {
      _setHasEmailError = false;
      return;
    }

    _setHasEmailError = _validateEmail(emailTextController.text);
  }

  void onPasswordFocusChange(bool isFocused) {
    if (isFocused) {
      _setHasPasswordError = false;
      return;
    }

    _setHasPasswordError = validatePassword(passwordTextController.text);
  }

  bool _validateEmail(String input) => !EmailValidator.validate(input);

  bool validatePassword(String input) {
    const String passwordExpression = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regExp = RegExp(passwordExpression);

    return !regExp.hasMatch(input);
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }
}
