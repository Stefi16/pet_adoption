import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/registration/registration_viewmodel.dart';
import 'package:pet_adoption/authentication/widgets/auth_text_button.dart';
import 'package:pet_adoption/authentication/widgets/authentication_background.dart';
import 'package:pet_adoption/authentication/widgets/password_textfield.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:pet_adoption/widgets/screen_padding.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_auth_logo.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/email_textfield.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return AuthenticationBackground(
      isDirectionReversed: true,
      child: KeyboardUnfocuser(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ScreenPadding(
            child: ViewModelBuilder<RegistrationViewModel>.reactive(
              viewModelBuilder: () => RegistrationViewModel(),
              builder: (context, viewModel, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppAuthLogo(),
                  EmailTextField(viewModel: viewModel),
                  PasswordTextField(
                    viewModel: viewModel,
                    textInputAction: TextInputAction.next,
                  ),
                  _VerifyPasswordTextField(
                    viewModel: viewModel,
                  ),
                  CustomButton(
                    text: text.register,
                    onTap: () => viewModel.registerUser(),
                    isLoading: viewModel.isLoading,
                  ),
                  AuthTextButton(
                    text: text.alreadyHaveAnAccount,
                    clickableText: text.backToLogin,
                    onButtonTap: () => viewModel.goToLoginPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VerifyPasswordTextField extends StatelessWidget {
  const _VerifyPasswordTextField({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final RegistrationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: viewModel.confirmPasswordTextController,
          label: text.confirmPassword,
          isPassword: true,
          obscureText: viewModel.shouldHideConfirmPassword,
          toggleVisibility: () => viewModel.toggleConfirmPasswordVisibility(),
          textInputAction: TextInputAction.done,
          hasError: viewModel.hasConfirmPasswordError,
          onFocusChanged: viewModel.onConfirmPasswordFocusChange,
          focusNode: viewModel.confirmPasswordFocusNode,
        ),
        if (viewModel.hasConfirmPasswordError) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              viewModel.confirmPasswordError,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
            ),
          ),
        ],
        SizedBox(height: viewModel.hasEmailError ? 16 : 20.0),
      ],
    );
  }
}
