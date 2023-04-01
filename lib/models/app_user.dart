import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  String id;
  String email;
  String? username;
  List<String> favouritePosts;
  DateTime dateJoined;
  String? picture;
  String? phone;

  AppUser({
    required this.id,
    required this.email,
    this.username,
    required this.favouritePosts,
    required this.dateJoined,
    this.picture,
    this.phone,
  });

  factory AppUser.createNew(String id, String email) {
    return AppUser(
      id: id,
      email: email,
      favouritePosts: [],
      dateJoined: DateTime.now(),
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
