import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/app_auth_logo.dart';
import 'package:pet_adoption/main/chat/all_chats/all_chats_viewmodel.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/chat_model.dart';
import '../../../widgets/profile_photo.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phoneWidth = MediaQuery.of(context).size.width;
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const AppAuthLogo(
          removeBottomPadding: true,
        ),
      ),
      body: ViewModelBuilder<AllChatsViewModel>.reactive(
        viewModelBuilder: () => AllChatsViewModel(),
        onViewModelReady: (vm) => vm.init(),
        builder: (context, viewModel, child) {
          final chats = viewModel.getChats;

          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final currentChat = chats.elementAt(index);
              final String email =
                  viewModel.getOtherUserEmail(currentChat) ?? '';
              final String username =
                  viewModel.getOtherUserName(currentChat) ?? '';
              final messages = currentChat.messages;

              if (messages.isEmpty) {
                return const SizedBox.shrink();
              }

              final lastMessage = messages.last;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => viewModel.goToChatScreen(
                    animalAdoption: viewModel.getAdoption(currentChat),
                    currentUser: viewModel.getCurrentUser(currentChat),
                    userPostedAdoption: viewModel.getSender(currentChat),
                  ),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        ProfilePhoto(
                          photoSize: 70,
                          photoUrl: viewModel
                              .getOtherUserProfilePhotoUrl(currentChat),
                          email: email,
                          username: username,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '(${viewModel.getAdoptionName(currentChat).capitalizeFirstLetter()})',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                if (username.isEmpty)
                                  Text(
                                    email,
                                    style: TextStyle(
                                      color: theme.iconTheme.color,
                                      fontSize: 15,
                                    ),
                                  )
                                else
                                  Text(username),
                              ],
                            ),
                            if (lastMessage.type == MessagesTypes.text)
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: phoneWidth * 0.6,
                                ),
                                child: Text(
                                  lastMessage.content,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontWeight:
                                        viewModel.shouldShowNotRead(lastMessage)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            else
                              Text(
                                text.photoWasSent,
                                style: TextStyle(
                                  fontWeight:
                                      viewModel.shouldShowNotRead(lastMessage)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        if (viewModel.shouldShowNotRead(lastMessage))
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        Text(
                          viewModel.getProperTimeOrDate(lastMessage),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
