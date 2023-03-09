import 'package:flutter/material.dart';

class ChooseTypeText extends StatelessWidget {
  const ChooseTypeText({
    Key? key,
    required this.text,
    this.noDots = false,
  }) : super(key: key);

  final String text;
  final bool noDots;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      noDots ? text : '$text:',
      style: TextStyle(
        fontSize: 15,
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
