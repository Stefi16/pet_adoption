import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

part 'chat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatModel {
  final String chatId;
  final String senderId;
  final String posterId;
  final String adoptionId;
  List<MessagesModel> messages;

  ChatModel({
    required this.adoptionId,
    required this.messages,
    required this.posterId,
    required this.senderId,
    required this.chatId,
  });

  factory ChatModel.newChat({
    required String adoptionId,
    required String posterId,
    required String senderId,
  }) {
    return ChatModel(
      adoptionId: adoptionId,
      messages: [],
      posterId: posterId,
      senderId: senderId,
      chatId: const Uuid().v4(),
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

enum MessagesTypes {
  text,
  image,
}

@JsonSerializable()
class MessagesModel {
  final String authorId;
  final DateTime createdAt;
  final String id;
  final MessagesTypes type;
  final String content;
  final String? url;
  types.Status? status;

  MessagesModel({
    required this.id,
    required this.type,
    required this.authorId,
    required this.content,
    required this.createdAt,
    this.url,
    this.status,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);
}
