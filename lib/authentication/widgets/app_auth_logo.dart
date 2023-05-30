import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAuthLogo extends StatelessWidget {
  const AppAuthLogo({
    Key? key,
    this.removeBottomPadding = false,
  }) : super(key: key);

  final bool removeBottomPadding;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: removeBottomPadding ? 0 : 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(
            text.appName,
            style: GoogleFonts.marckScript(
              fontSize: 30,
              color: theme.scaffoldBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
