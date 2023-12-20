import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String idAccount;
  String fullName;
  String? avatar;
  DateTime? birthDay;
  String? address;
  int? sex;

  UserInfo(
    this.idAccount,
    this.fullName,
    this.avatar,
    this.birthDay,
    this.address,
    this.sex,
  );

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  int getAge() {
    return DateTime.now().difference(birthDay!).inDays ~/ 365;
  }
}
