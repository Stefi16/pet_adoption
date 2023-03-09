import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/custom_textfield.dart';
import 'package:pet_adoption/widgets/dialogs/widgets/dialog_buttons_row.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_profile_details_dialog_viewmodel.dart';

class AddProfileDetailsDialog extends StatelessWidget {
  const AddProfileDetailsDialog({
    Key? key,
    required this.completer,
    required this.request,
    this.isPhoneDialog = false,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;
  final bool isPhoneDialog;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Dialog(
      child: KeyboardUnfocuser(
        child: UniversalPadding(
          child: ViewModelBuilder<AddProfileDetailsDialogViewModel>.nonReactive(
            viewModelBuilder: () =>
                AddProfileDetailsDialogViewModel(isPhoneDialog),
            onViewModelReady: (vm) => vm.init(),
            builder: (context, viewModel, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isPhoneDialog ? text.addPhone : text.addUsername,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _UserDetailsTextField(
                  completerFunction: () => _confirmUsername(viewModel),
                  isPhoneDialog: isPhoneDialog,
                ),
                const SizedBox(height: 40),
                DialogButtonsRow(
                  onCancel: () => completer(
                    DialogResponse(
                      confirmed: false,
                    ),
                  ),
                  onConfirm: () => _confirmUsername(viewModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmUsername(AddProfileDetailsDialogViewModel viewModel) {
    viewModel.validateField();

    if (viewModel.hasFieldError) {
      return;
    }

    final input = viewModel.textController.text;
    completer(
      DialogResponse(
        confirmed: true,
        data: input,
      ),
    );
  }
}

class _UserDetailsTextField
    extends ViewModelWidget<AddProfileDetailsDialogViewModel> {
  const _UserDetailsTextField({
    Key? key,
    required this.completerFunction,
    required this.isPhoneDialog,
  }) : super(key: key);

  final VoidCallback completerFunction;
  final bool isPhoneDialog;

  @override
  Widget build(
      BuildContext context, AddProfileDetailsDialogViewModel viewModel) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        CustomTextField(
          controller: viewModel.textController,
          label: isPhoneDialog ? text.phone : text.username,
          hasError: viewModel.hasFieldError,
          isBorderPrimaryColor: true,
          onFocusChanged: viewModel.onFocusChange,
          textInputAction: TextInputAction.done,
          onEditingComplete: completerFunction,
          focusNode: viewModel.focusNode,
          keyboardType: isPhoneDialog ? TextInputType.phone : null,
        ),
        if (viewModel.hasFieldError)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              isPhoneDialog ? text.phoneError : text.usernameError,
              style: TextStyle(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
