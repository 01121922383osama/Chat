import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/routs_name.dart';
import '../../global.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (Global.storageServices.getIsLoggedIn()) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouts.homePage,
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouts.loginRout,
          (route) => false,
        );
      }
    });
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/chat.json'),
      ),
    );
  }
}
