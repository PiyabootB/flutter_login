// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      token: json['token'] as String,
      avatar: json['avatar'] as String,
      firstname: json['first_name'] as String,
      id: json['id'] as int,
      errorcode: json['errorcode'] as int,
      lastname: json['last_name'] as String,
      email: json['e_mail'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'errorcode': instance.errorcode,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'e_mail': instance.email,
      'avatar': instance.avatar,
      'token': instance.token
    };
