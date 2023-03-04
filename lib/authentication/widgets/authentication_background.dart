import 'package:flutter/material.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({
    Key? key,
    required this.child,
    this.isDirectionReversed = false,
  }) : super(key: key);

  final Widget child;
  final bool isDirectionReversed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: isDirectionReversed ? Alignment.topLeft : Alignment.topRight,
          end: isDirectionReversed
              ? Alignment.bottomRight
              : Alignment.bottomLeft,
          stops: const [
            0.1,
            0.3,
            0.5,
            0.7,
            0.9,
          ],
          colors: [
            theme.primaryColor,
            theme.primaryColor.withOpacity(0.5),
            theme.primaryColor.withOpacity(0.3),
            theme.primaryColor.withOpacity(0.5),
            theme.primaryColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
