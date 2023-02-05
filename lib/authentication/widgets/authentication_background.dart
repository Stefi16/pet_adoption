import 'package:flutter/material.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
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
