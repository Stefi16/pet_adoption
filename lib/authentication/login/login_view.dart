import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/authentication_background.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../widgets/custom_textfield.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AuthenticationBackground(
      child: KeyboardUnfocuser(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ViewModelBuilder<LoginViewModel>.nonReactive(
              viewModelBuilder: () => LoginViewModel(),
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/backgrounds/paw.png',
                          width: 30,
                          fit: BoxFit.cover,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          text.appName,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    const _EmailTextField(),
                    const _PasswordTextField(),
                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          text.login,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => viewModel.login(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text.dontHaveAccount,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () => viewModel.goToRegistrationPage(),
                          child: Text(
                            text.registerHere,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends ViewModelWidget<LoginViewModel> {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          focusNode: viewModel.passwordFocusNode,
          controller: viewModel.passwordTextController,
          label: text.password,
          isPassword: true,
          obscureText: viewModel.shouldHidePassword,
          toggleVisibility: () => viewModel.toggleVisibility(),
          textInputAction: TextInputAction.done,
          hasError: viewModel.hasPasswordError,
          onFocusChanged: viewModel.onPasswordFocusChange,
        ),
        if (viewModel.hasPasswordError) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text.invalidPassword,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        ],
        SizedBox(height: viewModel.hasEmailError ? 17 : 20.0),
      ],
    );
  }
}

class _EmailTextField extends ViewModelWidget<LoginViewModel> {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: text.email,
          controller: viewModel.emailTextController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            viewModel.passwordFocusNode.requestFocus();
          },
          onFocusChanged: viewModel.onEmailFocusChange,
          hasError: viewModel.hasEmailError,
        ),
        if (viewModel.hasEmailError) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text.invalidEmail,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        ],
        SizedBox(height: viewModel.hasEmailError ? 17 : 20.0),
      ],
    );
  }
}
