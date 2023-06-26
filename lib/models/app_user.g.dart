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
      phone: json['phone'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
      currentMobileTheme: $enumDecodeNullable(
              _$FlexSchemeEnumMap, json['currentMobileTheme']) ??
          FlexScheme.aquaBlue,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'favouritePosts': instance.favouritePosts,
      'dateJoined': instance.dateJoined.toIso8601String(),
      'picture': instance.picture,
      'phone': instance.phone,
      'isAdmin': instance.isAdmin,
      'currentMobileTheme': _$FlexSchemeEnumMap[instance.currentMobileTheme]!,
      'isDarkMode': instance.isDarkMode,
    };

const _$FlexSchemeEnumMap = {
  FlexScheme.material: 'material',
  FlexScheme.materialHc: 'materialHc',
  FlexScheme.blue: 'blue',
  FlexScheme.indigo: 'indigo',
  FlexScheme.hippieBlue: 'hippieBlue',
  FlexScheme.aquaBlue: 'aquaBlue',
  FlexScheme.brandBlue: 'brandBlue',
  FlexScheme.deepBlue: 'deepBlue',
  FlexScheme.sakura: 'sakura',
  FlexScheme.mandyRed: 'mandyRed',
  FlexScheme.red: 'red',
  FlexScheme.redWine: 'redWine',
  FlexScheme.purpleBrown: 'purpleBrown',
  FlexScheme.green: 'green',
  FlexScheme.money: 'money',
  FlexScheme.jungle: 'jungle',
  FlexScheme.greyLaw: 'greyLaw',
  FlexScheme.wasabi: 'wasabi',
  FlexScheme.gold: 'gold',
  FlexScheme.mango: 'mango',
  FlexScheme.amber: 'amber',
  FlexScheme.vesuviusBurn: 'vesuviusBurn',
  FlexScheme.deepPurple: 'deepPurple',
  FlexScheme.ebonyClay: 'ebonyClay',
  FlexScheme.barossa: 'barossa',
  FlexScheme.shark: 'shark',
  FlexScheme.bigStone: 'bigStone',
  FlexScheme.damask: 'damask',
  FlexScheme.bahamaBlue: 'bahamaBlue',
  FlexScheme.mallardGreen: 'mallardGreen',
  FlexScheme.espresso: 'espresso',
  FlexScheme.outerSpace: 'outerSpace',
  FlexScheme.blueWhale: 'blueWhale',
  FlexScheme.sanJuanBlue: 'sanJuanBlue',
  FlexScheme.rosewood: 'rosewood',
  FlexScheme.blumineBlue: 'blumineBlue',
  FlexScheme.flutterDash: 'flutterDash',
  FlexScheme.materialBaseline: 'materialBaseline',
  FlexScheme.verdunHemlock: 'verdunHemlock',
  FlexScheme.dellGenoa: 'dellGenoa',
  FlexScheme.custom: 'custom',
};
