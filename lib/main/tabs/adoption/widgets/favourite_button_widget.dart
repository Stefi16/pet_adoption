import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

class FavouriteButtonWidget extends StatefulWidget {
  const FavouriteButtonWidget({
    Key? key,
    required this.isFavourite,
    required this.onTap,
  }) : super(key: key);

  final bool isFavourite;
  final VoidCallback onTap;

  @override
  State<FavouriteButtonWidget> createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isFavourite
        ? _animationController.forward()
        : _animationController.reverse();

    return GestureDetector(
      onTap: widget.onTap,
      child: Lottie.asset(
        Icons8.heart_color,
        repeat: false,
        controller: _animationController,
        fit: BoxFit.fill,
      ),
    );
  }
}
