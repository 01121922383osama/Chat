import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'login_page',
        (route) => false,
      );
    });
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/chat.json'),
      ),
    );
  }
}
