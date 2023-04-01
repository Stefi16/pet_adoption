// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      adoptionId: json['adoptionId'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posterId: json['posterId'] as String,
      senderId: json['senderId'] as String,
      chatId: json['chatId'] as String,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'senderId': instance.senderId,
      'posterId': instance.posterId,
      'adoptionId': instance.adoptionId,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

MessagesModel _$MessagesModelFromJson(Map<String, dynamic> json) =>
    MessagesModel(
      id: json['id'] as String,
      type: $enumDecode(_$MessagesTypesEnumMap, json['type']),
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      url: json['url'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$MessagesModelToJson(MessagesModel instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'type': _$MessagesTypesEnumMap[instance.type]!,
      'content': instance.content,
      'url': instance.url,
      'status': _$StatusEnumMap[instance.status],
    };

const _$MessagesTypesEnumMap = {
  MessagesTypes.text: 'text',
  MessagesTypes.image: 'image',
};

const _$StatusEnumMap = {
  types.Status.delivered: 'delivered',
  types.Status.error: 'error',
  types.Status.seen: 'seen',
  types.Status.sending: 'sending',
  types.Status.sent: 'sent',
};
