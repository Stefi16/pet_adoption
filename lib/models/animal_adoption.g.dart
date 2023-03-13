// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_adoption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAdoption _$AnimalAdoptionFromJson(Map<String, dynamic> json) =>
    AnimalAdoption(
      userId: json['userId'] as String,
      animalName: json['animalName'] as String,
      genderType: $enumDecode(_$AnimalGenderEnumMap, json['genderType']),
      animalType: $enumDecode(_$AnimalTypeEnumMap, json['animalType']),
      isApproved: json['isApproved'] as bool,
      breed: json['breed'] as String?,
      country: json['country'] as String,
      city: json['city'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String?,
      animalAge: AnimalAge.fromJson(json['animalAge'] as Map<String, dynamic>),
      adoptionId: json['adoptionId'] as String,
      datePublished: json['datePublished'] == null
          ? null
          : DateTime.parse(json['datePublished'] as String),
    );

Map<String, dynamic> _$AnimalAdoptionToJson(AnimalAdoption instance) {
  final val = <String, dynamic>{
    'adoptionId': instance.adoptionId,
    'userId': instance.userId,
    'animalName': instance.animalName,
    'genderType': _$AnimalGenderEnumMap[instance.genderType]!,
    'animalType': _$AnimalTypeEnumMap[instance.animalType]!,
    'isApproved': instance.isApproved,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('breed', instance.breed);
  val['country'] = instance.country;
  val['city'] = instance.city;
  val['description'] = instance.description;
  writeNotNull('photoUrl', instance.photoUrl);
  val['animalAge'] = instance.animalAge.toJson();
  val['datePublished'] = instance.datePublished?.toIso8601String();
  return val;
}

const _$AnimalGenderEnumMap = {
  AnimalGender.female: 'female',
  AnimalGender.male: 'male',
};

const _$AnimalTypeEnumMap = {
  AnimalType.cat: 'cat',
  AnimalType.dog: 'dog',
  AnimalType.bird: 'bird',
  AnimalType.other: 'other',
};
