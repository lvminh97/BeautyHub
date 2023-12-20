import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/user_info.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class InitEditProfileState extends EditProfileState {}

class ChooseBirthDayState extends EditProfileState {
  final DateTime dateTime;

  const ChooseBirthDayState(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class DisplayEditProfileState extends EditProfileState {
  final UserInfo userInfo;

  const DisplayEditProfileState(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}
