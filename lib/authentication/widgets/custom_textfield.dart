import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    this.controller,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.onFocusChanged,
    this.onChanged,
    this.obscureText = false,
    this.isPassword = false,
    this.toggleVisibility,
    this.onEditingComplete,
    this.focusNode,
    required this.hasError,
    this.isBorderPrimaryColor = false,
    this.maxLines = 1,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? toggleVisibility;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool hasError;
  final bool isBorderPrimaryColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color borderColor =
        isBorderPrimaryColor ? theme.primaryColor : Colors.white;
    final Color errorColor = theme.colorScheme.error;
    final Color currentColor = hasError ? errorColor : borderColor;

    return Focus(
      onFocusChange: onFocusChanged,
      child: TextFormField(
        style: TextStyle(
          color: currentColor,
        ),
        maxLines: maxLines,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: currentColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: hasError ? errorColor : borderColor.withOpacity(0.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: currentColor,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: toggleVisibility,
            child: _PasswordFieldIcon(
              hasError: hasError,
              isPassword: isPassword,
              obscureText: obscureText,
              errorColor: errorColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordFieldIcon extends StatelessWidget {
  const _PasswordFieldIcon({
    Key? key,
    required this.isPassword,
    required this.obscureText,
    required this.hasError,
    required this.errorColor,
  }) : super(key: key);

  final bool obscureText;
  final bool isPassword;
  final bool hasError;
  final Color errorColor;

  @override
  Widget build(BuildContext context) {
    if (!isPassword) {
      return const SizedBox.shrink();
    }

    if (obscureText) {
      return Icon(
        Icons.visibility,
        color: hasError ? Colors.red : Colors.white,
        size: 20,
      );
    }

    return Icon(
      Icons.visibility_off,
      color: hasError ? Colors.red : Colors.white,
      size: 20,
    );
  }
}
