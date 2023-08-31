import 'package:chat/controller/Login_Controller/login_controller.dart';
import 'package:chat/controller/login_Bloc/login_bloc.dart';
import 'package:chat/controller/login_Bloc/login_event.dart';
import 'package:chat/controller/login_Bloc/login_state.dart';
import 'package:flutter/gestures.dart';
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
import '../../../core/routs_name.dart';

class BodyLogInPage extends StatelessWidget {
  const BodyLogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
                text: 'Login',
                fontSize: 35,
              ),
              SizedBox(
                height: CustomMediaQuery(context).screenHeight / 5,
                child: Lottie.asset('assets/images/chat.json'),
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
                  context.read<LoginBloc>().add(EmailEvent(value));
                },
              ),
              SizedBox(height: CustomMediaQuery(context).screenHeight / 60),
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
                    context.read<LoginBloc>().add(PasswordEvent(value));
                  },
                ),
              ),
              SizedBox(height: CustomMediaQuery(context).screenHeight / 40),
              AnimationButtonWidget(
                text: 'Login',
                function: () {
                  LoginController(context: context).hundleEmailLogIn();
                },
              ),
              SizedBox(height: CustomMediaQuery(context).screenHeight / 30),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account? ",
                    ),
                    TextSpan(
                      text: "Register",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(AppRouts.register);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
