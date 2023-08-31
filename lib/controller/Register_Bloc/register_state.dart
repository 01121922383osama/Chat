class RegisterState {
  final String userName;
  final String email;
  final String password;
  final String rePeatpassword;
  const RegisterState(
      {this.userName = '',
      this.email = '',
      this.password = '',
      this.rePeatpassword = ''});
  RegisterState copyWith({
    String? userName,
    String? email,
    String? password,
    String? rePeatpassword,
  }) {
    return RegisterState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePeatpassword: rePeatpassword ?? this.rePeatpassword,
    );
  }
}
