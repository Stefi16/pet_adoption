import 'package:flutter/material.dart';

class UniversalPadding extends StatelessWidget {
  const UniversalPadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
