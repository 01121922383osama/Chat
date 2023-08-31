import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/Login/login_page.dart';
import 'Pages/Register/register_page.dart';
import 'Pages/Splash/splash_page.dart';
import 'constants/app_colors.dart';
import 'controller/ObscureText_Bloc/obscure_text_bloc.dart';
import 'controller/login_Bloc/login_bloc.dart';
import 'core/routs_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ObscureTextBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              color: Colors.white,
            ),
            headlineLarge: TextStyle(
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
            ),
            headlineSmall: TextStyle(
              color: Colors.white,
            ),
            displayLarge: TextStyle(
              color: Colors.white,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
            ),
            displaySmall: TextStyle(
              color: Colors.white,
            ),
            labelLarge: TextStyle(
              color: Colors.white,
            ),
            labelMedium: TextStyle(
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              color: Colors.white,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.background),
          useMaterial3: true,
        ),
        initialRoute: AppRouts.initial,
        routes: {
          AppRouts.initial: (context) => const SplashPage(),
          AppRouts.loginRout: (context) => const LoginPage(),
          AppRouts.register: (context) => const RegisterPage(),
        },
      ),
    );
  }
}
