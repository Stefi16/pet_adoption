import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base_authentication_viewmodel.dart';
import 'custom_textfield.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final BaseAuthenticationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
