import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/auth_text_button.dart';
import 'package:pet_adoption/authentication/widgets/authentication_background.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/authentication/widgets/screen_padding.dart';
import 'package:stacked/stacked.dart';

import '../widgets/app_auth_logo.dart';
import '../widgets/email_textfield.dart';
import '../widgets/password_textfield.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return AuthenticationBackground(
      child: KeyboardUnfocuser(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ScreenPadding(
            child: ViewModelBuilder<LoginViewModel>.reactive(
              viewModelBuilder: () => LoginViewModel(),
              builder: (context, viewModel, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppAuthLogo(),
                  EmailTextField(
                    viewModel: viewModel,
                  ),
                  PasswordTextField(
                    viewModel: viewModel,
                    textInputAction: TextInputAction.done,
                  ),
                  CustomButton(
                    text: text.login,
                    onTap: () => viewModel.login(),
                    isLoading: viewModel.isLoading,
                  ),
                  AuthTextButton(
                    text: text.dontHaveAccount,
                    clickableText: text.registerHere,
                    onButtonTap: () => viewModel.goToRegistrationPage(),
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
