import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialSignUpState extends SignUpState {}

class SelectRoleAccountState extends SignUpState {
  final int role;

  SelectRoleAccountState(this.role);

  @override
  List<Object?> get props => [role];
}

class SuccessSignUpWithEmailPasswordState extends SignUpState {}

class ErrorSignUpState extends SignUpState {
  final String? message;

  ErrorSignUpState(this.message);

  @override
  List<Object?> get props => [message];
}
