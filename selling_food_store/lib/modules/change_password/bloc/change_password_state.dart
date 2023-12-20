import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitChangePasswordState extends ChangePasswordState {}

class GetCredentialState extends ChangePasswordState {
  final String oldPassword;

  GetCredentialState(this.oldPassword);

  @override
  List<Object?> get props => [oldPassword];
}

class ChangePasswordSuccessState extends ChangePasswordState {}

class ChangePasswordFailureState extends ChangePasswordState {
  final String error;

  ChangePasswordFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
