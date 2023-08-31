import 'package:chat/controller/Register_Bloc/register_Event.dart';
import 'package:chat/controller/Register_Bloc/register_bloc.dart';
import 'package:chat/controller/Register_Bloc/register_state.dart';
import 'package:chat/controller/Register_Controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/widgets/animation_button.dart';
import '../../../constants/widgets/base_text_formfield.dart';
import '../../../constants/widgets/base_text_widget.dart';
import '../../../constants/widgets/media_query.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_bloc.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_event.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_state.dart';

class BodyRegisterPage extends StatelessWidget {
  const BodyRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) => Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              baseTextWidget(
                alignment: Alignment.topCenter,
                context: context,
                text: 'Register',
                fontSize: 35,
              ),
              SizedBox(
                height: CustomMediaQuery(context).screenHeight / 5,
                child: Lottie.asset('assets/images/chat.json'),
              ),
              baseTextWidget(
                alignment: Alignment.centerLeft,
                context: context,
                text: 'Name:',
              ),
              baseTextFormField(
                context: context,
                hintText: 'Name',
                labelText: 'Name',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  context.read<RegisterBloc>().add(UserNameEvent(value));
                },
              ),
              baseTextWidget(
                alignment: Alignment.centerLeft,
                context: context,
                text: 'Email:',
              ),
              baseTextFormField(
                context: context,
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  context.read<RegisterBloc>().add(EmailEvent(value));
                },
              ),
              baseTextWidget(
                alignment: Alignment.centerLeft,
                context: context,
                text: 'Password:',
              ),
              BlocBuilder<ObscureTextBloc, ObscureTextSate>(
                builder: (context, state) => baseTextFormField(
                  context: context,
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIconData: IconButton(
                    onPressed: () {
                      context
                          .read<ObscureTextBloc>()
                          .add(IsDisAppear(state.isDisAppear));
                    },
                    icon: state.isDisAppear
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  isDisAppear: !state.isDisAppear,
                  onChanged: (value) {
                    context.read<RegisterBloc>().add(PasswordEvent(value));
                  },
                ),
              ),
              baseTextWidget(
                alignment: Alignment.centerLeft,
                context: context,
                text: 'RepeatPassword:',
              ),
              BlocBuilder<ObscureTextBloc, ObscureTextSate>(
                builder: (context, state) => baseTextFormField(
                  context: context,
                  hintText: 'RepeatPassword',
                  labelText: 'RepeatPassword',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIconData: IconButton(
                    onPressed: () {
                      context
                          .read<ObscureTextBloc>()
                          .add(IsDisAppear(state.isDisAppear));
                    },
                    icon: state.isDisAppear
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  isDisAppear: !state.isDisAppear,
                  onChanged: (value) {
                    context
                        .read<RegisterBloc>()
                        .add(RePeatPasswordEvent(value));
                  },
                ),
              ),
              SizedBox(height: CustomMediaQuery(context).screenHeight / 40),
              AnimationButtonWidget(
                text: 'Register',
                function: () {
                  RegisterController(context: context).handleEmailRegister();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
