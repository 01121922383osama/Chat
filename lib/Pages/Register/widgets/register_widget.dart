import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/animation_button.dart';
import '../../../constants/base_text_formfield.dart';
import '../../../constants/base_text_widget.dart';
import '../../../constants/media_query.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_bloc.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_event.dart';
import '../../../controller/ObscureText_Bloc/obscure_text_state.dart';

class BodyRegisterPage extends StatelessWidget {
  const BodyRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
              onChanged: () {},
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
              onChanged: () {},
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
                onChanged: () {},
              ),
            ),
            SizedBox(height: CustomMediaQuery(context).screenHeight / 40),
            AnimationButtonWidget(
              text: 'Register',
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
