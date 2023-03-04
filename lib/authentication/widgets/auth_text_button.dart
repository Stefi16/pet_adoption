import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    Key? key,
    required this.text,
    required this.clickableText,
    required this.onButtonTap,
  }) : super(key: key);

  final String text;
  final String clickableText;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: onButtonTap,
          child: Text(
            clickableText,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
