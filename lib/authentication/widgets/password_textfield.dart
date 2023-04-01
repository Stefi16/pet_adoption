import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base_authentication_viewmodel.dart';
import 'custom_textfield.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.viewModel,
    required this.textInputAction,
  }) : super(key: key);

  final BaseAuthenticationViewModel viewModel;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
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
          textInputAction: textInputAction,
          hasError: viewModel.hasPasswordError,
          onFocusChanged: viewModel.onPasswordFocusChange,
          onEditingComplete: viewModel.isRegister
              ? () => viewModel.confirmPasswordFocusNode.requestFocus()
              : null,
        ),
        if (viewModel.hasPasswordError) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text.invalidPassword,
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
