import 'dart:io';

import 'package:selling_food_store/models/user_info.dart';

abstract class EditProfileEvent {}

class OnInitEditProfileEvent extends EditProfileEvent {
  UserInfo userInfo;

  OnInitEditProfileEvent(this.userInfo);
}

class OnChooseBirthDayEvent extends EditProfileEvent {
  DateTime dateTime;

  OnChooseBirthDayEvent(this.dateTime);
}

class OnUpdateUserInfoEvent extends EditProfileEvent {
  String name;
  String address;
  DateTime dateTime;

  OnUpdateUserInfoEvent(this.name, this.address, this.dateTime);
}

class OnUpdateAvatarUserEvent extends EditProfileEvent {
  File imageFile;

  OnUpdateAvatarUserEvent(this.imageFile);
  
}
