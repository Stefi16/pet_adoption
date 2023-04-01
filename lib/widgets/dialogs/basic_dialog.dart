import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    final title = request.title;
    final description = request.description;
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 60,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: theme.iconTheme.color!,
                ),
              ),
            const SizedBox(height: 10),
            if (description != null)
              Text(
                description +
                    'dmddmdmdmdmkrjfnrekjfnrek lkenmfelknfmelk nlkefneklwfmnwelkv nlkewvnklewnflwkenfwekl lkwenmflwk',
                style: TextStyle(
                  fontSize: 17,
                  color: theme.iconTheme.color!,
                ),
                textAlign: TextAlign.center,
              ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () => completer(
                    DialogResponse(
                      confirmed: false,
                    ),
                  ),
                  child: Text(
                    text.done,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
