import 'dart:async';

import 'package:intl/intl.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/services/auth_service.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/chat_model.dart';
import '../../../services/database_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AllChatsViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<ChatModel> _chatModels = [];

  List<ChatModel> get getChats => _chatModels;

  late StreamSubscription<List<ChatModel>> _streamSubscription;

  void init() async {
    setBusy(true);

    final chats = await _databaseService.getChats();
    _resetChats(chats);

    _streamSubscription = _databaseService.getChatsStream().listen(
          _refreshChats,
        );

    setBusy(false);
  }

  void _refreshChats(List<ChatModel> chats) => _resetChats(chats);

  void _resetChats(List<ChatModel> chats) {
    _databaseService.chats.clear();
    final currentUser = _authService.currentUser;

    if (currentUser != null) {
      chats.removeWhere(
        (chat) =>
            chat.senderId != currentUser.uid &&
            chat.posterId != currentUser.uid,
      );
    }

    _databaseService.chats.addAll(chats);
    _chatModels = chats;
    notifyListeners();
  }

  String? getOtherUserProfilePhotoUrl(ChatModel currentChat) {
    final currentUser = _authService.currentUser;

    if (currentChat.senderId == currentUser?.uid) {
      return _databaseService.getUserById(currentChat.posterId).picture;
    }

    return _databaseService.getUserById(currentChat.senderId).picture;
  }

  String? getOtherUserName(ChatModel currentChat) {
    final currentUser = _authService.currentUser;

    if (currentChat.senderId == currentUser?.uid) {
      return _databaseService.getUserById(currentChat.posterId).username;
    }

    return _databaseService.getUserById(currentChat.senderId).username;
  }

  String? getOtherUserEmail(ChatModel currentChat) {
    final currentUser = _authService.currentUser;

    if (currentChat.senderId == currentUser?.uid) {
      return _databaseService.getUserById(currentChat.posterId).email;
    }

    return _databaseService.getUserById(currentChat.senderId).email;
  }

  String getAdoptionName(ChatModel currentChat) {
    final adoption = _databaseService.animalAdoptions.where(
      (adoption) => currentChat.adoptionId == adoption.adoptionId,
    );

    return adoption.first.animalName.removeWhiteSpaces();
  }

  AnimalAdoption getAdoption(ChatModel currentChat) {
    final adoption = _databaseService.animalAdoptions.where(
      (adoption) => currentChat.adoptionId == adoption.adoptionId,
    );

    return adoption.first;
  }

  AppUser getSender(ChatModel currentChat) {
    final user = _databaseService.getUserById(currentChat.senderId);

    return user;
  }

  AppUser getCurrentUser(ChatModel currentChat) {
    final user = _databaseService.getCurrentUser();

    return user;
  }

  void goToChatScreen({
    required AnimalAdoption animalAdoption,
    required AppUser currentUser,
    required AppUser userPostedAdoption,
  }) =>
      _navigationService.navigateTo(
        Routes.chatView,
        arguments: ChatViewArguments(
            animalAdoption: animalAdoption,
            currentUser: currentUser,
            userPostedAdoption: userPostedAdoption),
      );

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  String getProperTimeOrDate(MessagesModel message) {
    final now = DateTime.now();
    final messageCreatedAt = message.createdAt;

    final bool isMessageSentToday =
        now.difference(messageCreatedAt).inHours >= 24;

    if (!isMessageSentToday) {
      String formattedTime = DateFormat('HH:mm').format(messageCreatedAt);
      return formattedTime;
    }

    String formattedDate = DateFormat('dd.MM').format(messageCreatedAt);
    return formattedDate;
  }

  bool shouldShowNotRead(MessagesModel message) {
    final isLastMessageUnread = message.status != types.Status.seen;
    final hasTheCurrentUserSentTheMessage =
        message.authorId == _databaseService.getCurrentUser().id;

    return isLastMessageUnread && !hasTheCurrentUserSentTheMessage;
  }
}
