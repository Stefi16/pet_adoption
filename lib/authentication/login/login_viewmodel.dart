import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/authentication/base_authentication_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/auth_service.dart';

class LoginViewModel extends BaseAuthenticationViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  void login() async {
    if (hasTextFieldError() || isLoading) {
      return;
    }

    setIsLoading = true;

    final email = emailTextController.text;
    final password = passwordTextController.text;

    final result = await _authService.loginUser(email, password);

    if (result) {
      _navigationService.replaceWith(Routes.mainView);
    }

    setIsLoading = false;
  }

  @override
  bool hasTextFieldError() => hasEmailError || hasPasswordError;

  void goToRegistrationPage() => _navigationService.replaceWith(
        Routes.registrationView,
      );
}
