import 'package:flutter/material.dart';

import '../../../../utils/common_logic.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.type,
    required this.onChanged,
    required this.text,
    required this.color,
    required this.chosenType,
  }) : super(key: key);

  final T type;
  final void Function(T?)? onChanged;
  final String text;
  final Color color;
  final T? chosenType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: type,
          groupValue: chosenType,
          onChanged: onChanged,
          visualDensity: getMinimumDensity(),
        ),
        if (onChanged != null)
          GestureDetector(
            onTap: () => onChanged!(type),
            child: Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ),
        const SizedBox(width: 10),
      ],
    );
  }
}
