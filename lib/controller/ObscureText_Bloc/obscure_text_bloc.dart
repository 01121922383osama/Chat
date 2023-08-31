import 'package:flutter_bloc/flutter_bloc.dart';

import 'obscure_text_event.dart';
import 'obscure_text_state.dart';

class ObscureTextBloc extends Bloc<ObscureTextEvent, ObscureTextSate> {
  ObscureTextBloc() : super(const ObscureTextSate(isDisAppear: false)) {
    on<IsDisAppear>(_onTaped);
  }
  void _onTaped(IsDisAppear event, Emitter<ObscureTextSate> emit) {
    emit(state.copyWith(isDisAppear: !state.isDisAppear));
  }
}
