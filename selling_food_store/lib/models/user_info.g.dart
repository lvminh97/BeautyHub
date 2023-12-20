// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['idAccount'] as String,
      json['fullName'] as String,
      json['avatar'] as String?,
      json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      json['address'] as String?,
      json['sex'] as int?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'idAccount': instance.idAccount,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'birthDay': instance.birthDay?.toIso8601String(),
      'address': instance.address,
      'sex': instance.sex,
    };
