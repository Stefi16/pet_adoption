import 'package:json_annotation/json_annotation.dart';

part 'animal_age.g.dart';

@JsonSerializable()
class AnimalAge {
  int months;
  int years;

  AnimalAge({
    required this.months,
    required this.years,
  });

  factory AnimalAge.fromJson(Map<String, dynamic> json) =>
      _$AnimalAgeFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalAgeToJson(this);
}
