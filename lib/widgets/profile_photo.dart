import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.photoSize,
    required this.photoUrl,
    required this.email,
    required this.username,
  }) : super(key: key);

  final double photoSize;
  final String? photoUrl;
  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.iconTheme.color!,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(
          photoSize,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          photoSize,
        ),
        child: CachedNetworkImage(
          imageUrl: photoUrl ?? '',
          progressIndicatorBuilder: (context, url, progress) {
            return Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            );
          },
          width: photoSize,
          height: photoSize,
          fit: BoxFit.fill,
          errorWidget: (_, __, ___) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColorDark,
            ),
            child: Center(
              child: Text(
                username.isEmpty
                    ? email[0].toUpperCase()
                    : username[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
