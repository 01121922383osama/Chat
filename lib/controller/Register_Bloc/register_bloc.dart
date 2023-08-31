import 'package:chat/controller/Register_Bloc/register_Event.dart';
import 'package:chat/controller/Register_Bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwrodEvent);
    on<RePeatPasswordEvent>(_rePasswrodEvent);
  }
  void _userNameEvent(UserNameEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwrodEvent(PasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rePasswrodEvent(
      RePeatPasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(rePeatpassword: event.repeatPassword));
  }
}
