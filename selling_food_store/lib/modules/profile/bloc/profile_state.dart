import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/models/user_info.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitProfileState extends ProfileState {}

class DisplayProfileState extends ProfileState {
  final UserInfo? userInfo;
  

  DisplayProfileState({this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}

class ChangeLanguageState extends ProfileState {
  final Locale locale;

  ChangeLanguageState(this.locale);

  @override
  List<Object?> get props => [locale];
}

class SignOutState extends ProfileState {}

class ConfirmSignOutState extends ProfileState {}

class CloseDialog extends ProfileState {}

class ErrorState extends ProfileState {
  final String error;

  ErrorState(this.error);
}
