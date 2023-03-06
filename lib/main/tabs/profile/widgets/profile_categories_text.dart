import 'package:flutter/material.dart';

class ProfileCategoriesText extends StatelessWidget {
  const ProfileCategoriesText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: theme.iconTheme.color!,
      ),
    );
  }
}
