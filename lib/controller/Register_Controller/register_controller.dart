import 'package:chat/controller/Register_Bloc/register_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/widgets/flutter_toast.dart';

class RegisterController {
  final BuildContext context;
  RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String repeatPassword = state.rePeatpassword;

    if (userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repeatPassword.isEmpty) {
      toastInfo(msg: 'All fields are required');
      return;
    }

    if (repeatPassword != password) {
      toastInfo(msg: 'Your password confirmation is wrong');
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
        await userCredential.user!.updateDisplayName(userName);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'userName': userName,
          'email': email,
          'password': password,
        });

        toastInfo(
            msg:
                'An email has been sent to your registered email. Please check your email inbox to activate your account.');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: 'The email is already in use');
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: 'The email address is not valid');
      }
    }
  }
}
