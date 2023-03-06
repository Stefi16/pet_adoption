import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/custom_textfield.dart';
import 'package:pet_adoption/widgets/dialogs/username_dialog_viewmodel.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../authentication/widgets/authentication_background.dart';

class UsernameDialog extends StatelessWidget {
  const UsernameDialog({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      child: KeyboardUnfocuser(
        child: UniversalPadding(
          child: ViewModelBuilder<UsernameDialogViewModel>.nonReactive(
            viewModelBuilder: () => UsernameDialogViewModel(),
            onViewModelReady: (vm) => vm.init(),
            builder: (context, viewModel, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text.addUsername,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _UsernameTextField(
                  completerFunction: () => _confirmUsername(viewModel),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => completer(
                        DialogResponse(
                          confirmed: false,
                        ),
                      ),
                      child: Text(
                        text.cancel,
                        style: TextStyle(
                          color: theme.textTheme.bodyMedium!.color!,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _confirmUsername(viewModel),
                      child: Text(
                        text.confirm,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmUsername(UsernameDialogViewModel viewModel) {
    viewModel.validateUsername();

    if (viewModel.hasUsernameError) {
      return;
    }

    final username = viewModel.usernameTextController.text;
    completer(
      DialogResponse(confirmed: true, data: username),
    );
  }
}

class _UsernameTextField extends ViewModelWidget<UsernameDialogViewModel> {
  const _UsernameTextField({
    Key? key,
    required this.completerFunction,
  }) : super(key: key);

  final VoidCallback completerFunction;
  @override
  Widget build(BuildContext context, UsernameDialogViewModel viewModel) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        CustomTextField(
          controller: viewModel.usernameTextController,
          label: text.username,
          hasError: viewModel.hasUsernameError,
          isBorderBlue: true,
          onFocusChanged: viewModel.onFocusChange,
          textInputAction: TextInputAction.done,
          onEditingComplete: completerFunction,
          focusNode: viewModel.usernameFocusNode,
        ),
        if (viewModel.hasUsernameError)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              text.usernameError,
              style: TextStyle(
                color: theme.colorScheme.error,
              ),
            ),
          )
      ],
    );
  }
}
