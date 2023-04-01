import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/models/chat_model.dart';
import 'package:uuid/uuid.dart';

types.User mapUserFromAppUser(AppUser appUser) {
  return types.User(
    id: appUser.id,
    imageUrl: appUser.picture,
    createdAt: appUser.dateJoined.millisecondsSinceEpoch,
    firstName: appUser.username ?? appUser.email,
  );
}

types.TextMessage mapMessageFromMessagesModel(
  MessagesModel messagesModel,
  AppUser author,
) {
  return types.TextMessage(
    author: mapUserFromAppUser(author),
    id: const Uuid().v4(),
    text: messagesModel.content,
    createdAt: messagesModel.createdAt.millisecondsSinceEpoch,
    type: types.MessageType.text,
    status: messagesModel.status,
    showStatus: true,
  );
}

types.ImageMessage mapImageMessageFromMessagesModel(
  MessagesModel messagesModel,
  AppUser author,
) {
  return types.ImageMessage(
    author: mapUserFromAppUser(author),
    id: const Uuid().v4(),
    name: messagesModel.content,
    size: 30,
    uri: messagesModel.url ?? '',
    createdAt: messagesModel.createdAt.millisecondsSinceEpoch,
    type: types.MessageType.image,
    status: messagesModel.status,
    showStatus: true,
  );
}

List<types.Message> mapMessagesFromMessagesModel(
  List<MessagesModel> messages,
  List<AppUser> users,
) {
  return messages.map(
    (message) {
      final author = users.where((user) => user.id == message.authorId).first;

      if (message.type == MessagesTypes.image) {
        return mapImageMessageFromMessagesModel(message, author);
      }

      return mapMessageFromMessagesModel(message, author);
    },
  ).toList();
}

MessagesModel mapTextMessageToMessageModel(types.TextMessage message) {
  return MessagesModel(
    id: message.id,
    type: MessagesTypes.text,
    authorId: message.author.id,
    content: message.text,
    createdAt: DateTime.fromMillisecondsSinceEpoch(message.createdAt!),
    status: message.status,
  );
}

MessagesModel mapImageMessageToMessageModel(types.ImageMessage message) {
  return MessagesModel(
    id: message.id,
    type: MessagesTypes.image,
    authorId: message.author.id,
    content: message.name,
    url: message.uri,
    createdAt: DateTime.fromMillisecondsSinceEpoch(message.createdAt!),
    status: message.status,
  );
}
