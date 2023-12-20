// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credential _$CredentialFromJson(Map<String, dynamic> json) => Credential(
      idUser: json['idUser'] as String,
      email: json['email'] as String,
      createAt: DateTime.parse(json['create_at'] as String),
    );

Map<String, dynamic> _$CredentialToJson(Credential instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'email': instance.email,
      'create_at': instance.createAt.toIso8601String(),
    };
