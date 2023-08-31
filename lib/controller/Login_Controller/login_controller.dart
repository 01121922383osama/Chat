import 'package:chat/controller/login_Bloc/login_bloc.dart';
import 'package:chat/core/routs_name.dart';
import 'package:chat/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/widgets/flutter_toast.dart';

class LoginController {
  final BuildContext context;
  const LoginController({required this.context});

  Future<void> hundleEmailLogIn() async {
    final state = context.read<LoginBloc>().state;
    String email = state.email;
    String password = state.password;
    if (email.isEmpty) {
      toastInfo(msg: 'You need to fill email address');
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: 'You need to fill password');
      return;
    }
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        toastInfo(msg: 'You don`t exist');
        return;
      }
      if (userCredential.user!.emailVerified) {
        toastInfo(msg: 'You need to verify your email account');
        return;
      }
      var user = userCredential.user;
      if (user != null) {
        await Global.storageServices.setLoggedIn(true);
        Future.delayed(
            Duration.zero,
            () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.homePage,
                  (route) => false,
                ));
      } else {
        Future.delayed(
            Duration.zero,
            () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.loginRout,
                  (route) => false,
                ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo(msg: 'No user found that email');
        return;
      } else if (e.code == 'wrong-password') {
        toastInfo(msg: 'Wrong password provided for that user');
        return;
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: 'Your email address format is wrong');
        return;
      }
    }
  }
}
