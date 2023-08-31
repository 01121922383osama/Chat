import 'package:flutter/material.dart';

import 'widgets/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: BodyRegisterPage(),
      ),
    );
  }
}
