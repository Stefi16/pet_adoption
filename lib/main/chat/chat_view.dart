import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/main/chat/chat_viewmodel.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/utils/mappers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
    required this.animalAdoption,
    required this.currentUser,
    required this.userPostedAdoption,
  }) : super(key: key);

  final AppUser currentUser;
  final AppUser userPostedAdoption;
  final AnimalAdoption animalAdoption;

  @override
  Widget build(BuildContext context) {
    final currentMappedUser = mapUserFromAppUser(currentUser);
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () => ChatViewModel(),
        onViewModelReady: (vm) => vm.init(
          adoption: animalAdoption,
          currentUser: currentUser,
          userPostedAdoption: userPostedAdoption,
        ),
        builder: (context, viewModel, child) {
          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Chat(
            emptyState: Center(
              child: Text(
                text.noMessagesYet,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.primaryColor.withOpacity(0.6),
                ),
              ),
            ),
            onAttachmentPressed: () => viewModel.uploadPhoto(context),
            showUserAvatars: true,
            avatarBuilder: (userId) {
              final user = viewModel.getUser(userId);
              if ((user.picture ?? '').isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: user.picture!,
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  radius: 15,
                  child: Text(
                    user.username?[0] ?? user.email[0],
                  ),
                ),
              );
            },
            theme: DefaultChatTheme(
              sendButtonIcon: FaIcon(
                FontAwesomeIcons.paperPlane,
                color: theme.primaryColor,
              ),
              primaryColor: theme.primaryColor,
              secondaryColor: theme.primaryColor.withOpacity(0.2),
              inputBackgroundColor: theme.scaffoldBackgroundColor,
              inputContainerDecoration: BoxDecoration(
                border: Border.all(
                  color: theme.primaryColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              inputTextColor: theme.iconTheme.color!,
            ),
            messages: viewModel.messages,
            onSendPressed: (partialText) =>
                viewModel.onSendPressed(partialText),
            user: currentMappedUser,
          );
        },
      ),
    );
  }
}
