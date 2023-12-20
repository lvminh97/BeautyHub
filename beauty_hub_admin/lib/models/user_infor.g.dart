// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) => UserInfor(
      json['idUser'] as String,
      json['name'] as String,
      json['phone'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'idUser': instance.idUser,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
    };
