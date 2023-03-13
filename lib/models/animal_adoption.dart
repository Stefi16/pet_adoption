import 'package:json_annotation/json_annotation.dart';
import 'package:pet_adoption/utils/enums.dart';

import 'animal_age.dart';

part 'animal_adoption.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimalAdoption {
  String adoptionId;
  String userId;
  String animalName;
  AnimalGender genderType;
  AnimalType animalType;
  bool isApproved;
  @JsonKey(includeIfNull: false)
  String? breed;
  String country;
  String city;
  String description;
  @JsonKey(includeIfNull: false)
  String? photoUrl;
  AnimalAge animalAge;
  DateTime? datePublished;

  AnimalAdoption({
    required this.userId,
    required this.animalName,
    required this.genderType,
    required this.animalType,
    required this.isApproved,
    this.breed,
    required this.country,
    required this.city,
    required this.description,
    this.photoUrl,
    required this.animalAge,
    required this.adoptionId,
    this.datePublished,
  });

  factory AnimalAdoption.fromJson(Map<String, dynamic> json) =>
      _$AnimalAdoptionFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalAdoptionToJson(this);
}
