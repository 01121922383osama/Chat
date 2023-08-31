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
    String email = state.email.trim();
    String password = state.password.trim();
    if (email.isEmpty) {
      toastInfo(msg: 'You need to fill email address');
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: 'You need to fill password');
      return;
    }
    try {
      showDialog(
        context: context,
        builder: (context) => SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
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
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        return;
      }
      var user = userCredential.user;
      if (user != null) {
        await Global.storageServices.setLoggedIn(true);
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
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
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        return;
      } else if (e.code == 'wrong-password') {
        toastInfo(msg: 'Wrong password provided for that user');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        return;
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: 'Your email address format is wrong');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        return;
      }
      Future.delayed(
        const Duration(seconds: 1),
        () {
          toastInfo(msg: 'Check your internet connection');
          Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        },
      );
    }
  }
}
