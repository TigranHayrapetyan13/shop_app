import 'package:json_annotation/json_annotation.dart';

part 'user_class.g.dart';

enum Gender { male, female }

@JsonSerializable()
class UserName {
  final String email;
  final String name;
  final int age;
  final String secondName;
  final Gender gender;

  UserName(
      {required this.email,
      required this.name,
      required this.age,
      required this.gender,
      required this.secondName});

  factory UserName.fromJson(Map<String, dynamic> json) =>
      _$UserNameFromJson(json);

  Map<String, dynamic> toJson() => _$UserNameToJson(this);
}
