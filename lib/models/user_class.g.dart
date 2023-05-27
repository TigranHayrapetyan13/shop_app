// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserName _$UserNameFromJson(Map<String, dynamic> json) => UserName(
      email: json['email'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      secondName: json['secondName'] as String,
    );

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'age': instance.age,
      'secondName': instance.secondName,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
