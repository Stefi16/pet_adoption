import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double _photoSize = 100;

class AccountWidget extends ViewModelWidget<ProfileViewModel> {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    final email = viewModel.getCurrentUserEmail();
    final username = viewModel.getCurrentUserUsername();
    final bool isUsernamePresent = username.isNotEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => viewModel.uploadPhoto(context),
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
            width: _photoSize,
            height: _photoSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: viewModel.getPhotoUrl(),
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      );
                    },
                    fit: BoxFit.fitHeight,
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.iconTheme.color!.withOpacity(0.7),
                    ),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 20,
                      color: theme.scaffoldBackgroundColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => viewModel.editUsername(),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Text(
                    isUsernamePresent ? username : text.addUsername,
                    style: TextStyle(
                      fontSize: isUsernamePresent ? 20 : 15,
                      color: isUsernamePresent
                          ? theme.iconTheme.color!
                          : theme.iconTheme.color!.withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.edit,
                    size: 16,
                    color: isUsernamePresent
                        ? theme.iconTheme.color!
                        : theme.iconTheme.color!.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: TextStyle(
                fontSize: isUsernamePresent ? 15 : 20,
                color: isUsernamePresent
                    ? theme.iconTheme.color!.withOpacity(0.7)
                    : theme.iconTheme.color!,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
