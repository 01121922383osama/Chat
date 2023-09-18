import 'package:chat/Pages/GetAllUsers/get_all_users.dart';
import 'package:chat/Pages/ProfilePage/profile_page.dart';
import 'package:chat/controller/Register_Bloc/register_bloc.dart';
import 'package:chat/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/Login/login_page.dart';
import 'Pages/Register/register_page.dart';
import 'Pages/Splash/splash_page.dart';
import 'Pages/home/home_page.dart';
import 'constants/widgets/theme_app.dart';
import 'controller/ObscureText_Bloc/obscure_text_bloc.dart';
import 'controller/login_Bloc/login_bloc.dart';
import 'core/routs_name.dart';

void main() async {
  await Global.init();
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
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: themeData,
        initialRoute: AppRouts.initial,
        routes: {
          AppRouts.initial: (context) => const SplashPage(),
          AppRouts.homePage: (context) => const HomePage(),
          AppRouts.profilePage: (context) => const ProfilePage(),
          AppRouts.loginRout: (context) => const LoginPage(),
          AppRouts.register: (context) => const RegisterPage(),
          AppRouts.getAllUsers: (context) => const GetAllUsers(),
        },
      ),
    );
  }
}
