import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/src/messages/partial_text.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pet_adoption/models/chat_model.dart';
import 'package:pet_adoption/utils/mappers.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../app/app.locator.dart';
import '../../models/animal_adoption.dart';
import '../../models/app_user.dart';
import '../../services/database_service.dart';
import '../../services/image_upload_service.dart';

class ChatViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final ImageUploaderService _imageUploaderService =
      locator<ImageUploaderService>();

  late final AppUser _currentUser;
  late final AppUser _userPostedAdoption;
  late final AnimalAdoption _adoption;
  late ChatModel _chatModel;
  late StreamSubscription<ChatModel> _streamSubscription;

  List<types.Message> _messages = [];
  List<types.Message> get messages => _messages;

  void init({
    required AppUser currentUser,
    required AppUser userPostedAdoption,
    required AnimalAdoption adoption,
  }) async {
    _currentUser = currentUser;
    _userPostedAdoption = userPostedAdoption;
    _adoption = adoption;
    final currentChat = _databaseService.chats.where(
      (chat) => chat.adoptionId == adoption.adoptionId,
    );

    currentChat.where(
      (chat) =>
          (chat.posterId == currentUser.id &&
              chat.senderId == _userPostedAdoption.id) ||
          (chat.posterId == userPostedAdoption.id &&
              chat.senderId == currentUser.id),
    );

    setBusy(true);

    if (currentChat.isEmpty) {
      await _createChat();
    } else {
      _chatModel = currentChat.first;
      final messages = _chatModel.messages;

      _messages = mapMessagesFromMessagesModel(
        messages,
        _databaseService.getAllUsers(),
      );

      _messages.sort(
        (a, b) => b.createdAt!.compareTo(a.createdAt!),
      );
    }

    _streamSubscription = _databaseService
        .getChatStream(
          _chatModel.chatId,
        )
        .listen(
          _refreshChat,
        );

    await _readMessages();
    setBusy(false);
  }

  void _refreshChat(ChatModel newModel) {
    _chatModel = newModel;
    final index = _databaseService.chats.indexWhere(
      (chat) => chat.chatId == newModel.chatId,
    );
    _databaseService.chats[index] = newModel;
    _messages.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    notifyListeners();
  }

  AppUser getUser(String userId) {
    return _databaseService.getUsersById(userId);
  }

  void uploadPhoto(BuildContext context) async {
    final ImageUploadData result =
        await _imageUploaderService.showImagePickerModal(context);

    if (result.imageBytes.isEmpty || result.imageName.isEmpty) {
      return;
    }

    final compressedImage = await _imageUploaderService.compressBytes(
      result.imageBytes,
    );

    final String imageUrl = await _databaseService.uploadChatImage(
      compressedImage,
      _currentUser.id,
    );

    final imageMessage = types.ImageMessage(
      uri: imageUrl,
      author: mapUserFromAppUser(_currentUser),
      id: const Uuid().v4(),
      name: result.imageName,
      size: 30,
      status: types.Status.sent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    _messages.add(imageMessage);
    _messages.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );

    _chatModel.messages.add(mapImageMessageToMessageModel(imageMessage));
    await _databaseService.addChat(_chatModel);

    notifyListeners();
  }

  void onSendPressed(PartialText partialText) async {
    final result = types.TextMessage(
      author: mapUserFromAppUser(_currentUser),
      id: const Uuid().v4(),
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      status: types.Status.sent,
    );

    _chatModel.messages.add(
      mapTextMessageToMessageModel(result),
    );

    await _databaseService.addChat(_chatModel);

    messages.add(result);
    _messages.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    notifyListeners();
  }

  Future<void> _createChat() async {
    final newChat = ChatModel.newChat(
      adoptionId: _adoption.adoptionId,
      posterId: _userPostedAdoption.id,
      senderId: _currentUser.id,
    );

    await _databaseService.addChat(newChat);
    _chatModel = newChat;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<void> _readMessages() async {
    final List<MessagesModel> unreadMessages = _chatModel.messages
        .where(
          (message) =>
              message.status == types.Status.sent &&
              message.authorId != _currentUser.id,
        )
        .toList();

    if (unreadMessages.isNotEmpty) {
      for (final message in unreadMessages) {
        message.status = types.Status.seen;
      }
    }

    await _databaseService.addChat(_chatModel);
  }
}
