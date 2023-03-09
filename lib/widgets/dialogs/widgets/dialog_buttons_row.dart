import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogButtonsRow extends StatelessWidget {
  const DialogButtonsRow({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            text.cancel,
            style: TextStyle(
              color: theme.iconTheme.color,
              fontSize: 15,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            text.confirm,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
