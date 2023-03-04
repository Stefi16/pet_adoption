import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/authentication/base_authentication_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/services/auth_service.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/app_user.dart';

class RegistrationViewModel extends BaseAuthenticationViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  RegistrationViewModel() {
    isRegister = true;
  }

  TextEditingController get confirmPasswordTextController =>
      _confirmPasswordTextController;
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  bool get shouldHideConfirmPassword => _shouldHideConfirmPassword;
  bool _shouldHideConfirmPassword = true;
  set _setShouldHideConfirmPassword(bool value) {
    if (_shouldHideConfirmPassword != value) {
      _shouldHideConfirmPassword = value;
      notifyListeners();
    }
  }

  bool get hasConfirmPasswordError => _confirmPasswordError.isNotEmpty;

  String get confirmPasswordError => _confirmPasswordError;
  String _confirmPasswordError = '';
  set _setConfirmPasswordError(String value) {
    if (_confirmPasswordError != value) {
      _confirmPasswordError = value;
      notifyListeners();
    }
  }

  void toggleConfirmPasswordVisibility() =>
      _setShouldHideConfirmPassword = !_shouldHideConfirmPassword;

  void onConfirmPasswordFocusChange(bool isFocused) {
    if (isFocused) {
      _setConfirmPasswordError = '';
      return;
    }

    final text =
        AppLocalizations.of(StackedService.navigatorKey!.currentContext!)!;

    if (validatePassword(confirmPasswordTextController.text)) {
      _setConfirmPasswordError = text.invalidPassword;
      return;
    }

    if (passwordTextController.text != confirmPasswordTextController.text) {
      _setConfirmPasswordError = text.notMatchedPassword;
      return;
    }

    _setConfirmPasswordError = '';
  }

  void registerUser() async {
    if (hasTextFieldError() || isLoading) {
      return;
    }

    setIsLoading = true;

    final email = emailTextController.text;
    final password = confirmPasswordTextController.text;

    final UserCredential? registeredUser = await _authService.registerUser(
      email,
      password,
    );
    final String? newUserId = registeredUser?.user?.uid;

    if (newUserId != null) {
      final newUser = AppUser.createNew(newUserId, email);

      await _databaseService.addUser(newUser);

      _navigationService.replaceWith(Routes.mainView);
    }

    setIsLoading = false;
  }

  @override
  bool hasTextFieldError() =>
      hasEmailError || hasPasswordError || hasConfirmPasswordError;

  void goToLoginPage() => _navigationService.replaceWith(
        Routes.loginView,
      );
}
