import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.text,
    this.noPadding = false,
  }) : super(key: key);

  final String text;
  final bool noPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: noPadding ? EdgeInsets.zero : const EdgeInsets.only(left: 12.0),
      child: Text(
        text,
        style: TextStyle(
          color: theme.colorScheme.error,
          fontSize: 12,
        ),
      ),
    );
    ;
  }
}
