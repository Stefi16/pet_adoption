import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppAuthLogo extends StatelessWidget {
  const AppAuthLogo({
    Key? key,
    this.removeBottomPadding = false,
  }) : super(key: key);

  final bool removeBottomPadding;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: removeBottomPadding ? 0 : 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.pets_outlined,
            color: Colors.white,
            size: 35,
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
    );
  }
}
