// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as String,
      json['idUser'] as String,
      json['content'] as String?,
      (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'idUser': instance.idUser,
      'content': instance.content,
      'rating': instance.rating,
    };
