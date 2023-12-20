abstract class ChangePasswordEvent {}

class OnInitChangePasswordEvent extends ChangePasswordEvent {}

class OnGetCredentialEvent extends ChangePasswordEvent {
  String password;

  OnGetCredentialEvent(this.password);
}

class OnChangePasswordEvent extends ChangePasswordEvent {
  String oldPassword;
  String password;

  OnChangePasswordEvent(this.oldPassword, this.password);
}

class OnErrorEvent extends ChangePasswordEvent {
  String error;

  OnErrorEvent(this.error);
}
