import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSignInState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInFailureState extends SignInState {
  final String error;

  SignInFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class CloseDialogState extends SignInState {}
