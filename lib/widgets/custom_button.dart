import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isLoading,
    this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.maxFinite,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !isLoading) ...[
              icon!,
              const SizedBox(width: 10),
            ],
            isLoading
                ? LoadingAnimationWidget.hexagonDots(
                    color: Colors.white,
                    size: 30,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.colorScheme.background,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
