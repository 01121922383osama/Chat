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
    String userName = state.userName.trim();
    String email = state.email.trim();
    String password = state.password.trim();
    String repeatPassword = state.rePeatpassword.trim();
    String imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/chat-73209.appspot.com/o/defaultImage%2FdefaultImage.png?alt=media&token=a8ddca03-acc7-4409-a329-0034007b5cd9';
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
    if (!email.contains('@')) {
      toastInfo(
          msg:
              'Invalid email address format. Please include the "@" symbol in your email address.');
      return;
    }
    try {
      //////////////////////////////////
      ///
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
      //////////////////////////////////
      ///
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user?.sendEmailVerification();
        await userCredential.user?.updateDisplayName(userName);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'userName': userName,
          'imageUrl': imageUrl,
          'email': email,
          'password': password,
        });

        toastInfo(
            msg:
                'An email has been sent to your registered email. Please check your email inbox to activate your account.');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: 'The password provided is too weak');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: 'The email is already in use');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: 'The email address is not valid');
        Future.delayed(Duration.zero, () => Navigator.of(context).pop());
      } else {
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
}
