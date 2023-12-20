import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  String idUser;
  String email;
  @JsonKey(name: 'create_at')
  DateTime createAt;

  Credential({
    required this.idUser,
    required this.email,
    required this.createAt,
  });

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}
