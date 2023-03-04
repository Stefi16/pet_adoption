// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      favouritePosts: (json['favouritePosts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dateJoined: DateTime.parse(json['dateJoined'] as String),
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'favouritePosts': instance.favouritePosts,
      'dateJoined': instance.dateJoined.toIso8601String(),
      'picture': instance.picture,
    };
