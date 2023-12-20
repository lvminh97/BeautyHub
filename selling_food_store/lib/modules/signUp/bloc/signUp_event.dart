abstract class SignUpEvent {}

class OnSignUpAccountEvent extends SignUpEvent {
  String email;
  String password;
  String name;
  DateTime? birthDay;
  int? sex;
  String? address;

  OnSignUpAccountEvent(this.email, this.password, this.name, this.birthDay,
      this.sex, this.address);
}

class OnInitInputUserProfileEvent extends SignUpEvent {}

class OnErrorEvent extends SignUpEvent {
  String message;

  OnErrorEvent(this.message);
}
