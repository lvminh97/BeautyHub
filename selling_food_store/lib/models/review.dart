import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  
  String id;
  String idUser;
  String? content;
  double rating;

  Review(
    this.id,
    this.idUser,
    this.content,
    this.rating,
  );

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
