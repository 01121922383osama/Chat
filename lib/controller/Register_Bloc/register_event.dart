// ignore_for_file: file_names

class RegisterEvent {
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent {
  final String userName;
  const UserNameEvent(this.userName);
}

class EmailEvent extends RegisterEvent {
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent {
  final String password;
  const PasswordEvent(this.password);
}

class RePeatPasswordEvent extends RegisterEvent {
  final String repeatPassword;
  const RePeatPasswordEvent(this.repeatPassword);
}
