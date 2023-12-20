abstract class SignInEvent {}

class OnUserSignInEvent extends SignInEvent {
  String email;
  String password;

  OnUserSignInEvent(this.email, this.password);
}

class OnSignInSuccesEvent extends SignInEvent {}

class OnSignInFailureEvent extends SignInEvent {
  String error;

  OnSignInFailureEvent(this.error);
}

class OnCloseDialogEvent extends SignInEvent {}
