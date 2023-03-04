import 'package:json_annotation/json_annotation.dart';
import 'package:pet_adoption/app/app.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  String id;
  String email;
  String? username;
  List<String> favouritePosts;
  DateTime dateJoined;
  String? picture;

  AppUser({
    required this.id,
    required this.email,
    this.username,
    required this.favouritePosts,
    required this.dateJoined,
    this.picture,
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
