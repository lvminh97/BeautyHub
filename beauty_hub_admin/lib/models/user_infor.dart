import 'package:json_annotation/json_annotation.dart';

part 'user_infor.g.dart';

@JsonSerializable()
class UserInfor {
  String idUser;
  String name;
  String? phone;
  String? address;

  UserInfor(this.idUser, this.name, this.phone, this.address);

  factory UserInfor.fromJson(Map<String, dynamic> json) =>
      _$UserInforFromJson(json);

  Map<String, dynamic> toJson() => _$UserInforToJson(this);
}