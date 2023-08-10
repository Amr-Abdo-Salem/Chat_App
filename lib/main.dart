// ignore_for_file: deprecated_member_use

import 'package:chatapp/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    blocObserver: SimplelocObserver(),
    () {
      // ignore: prefer_const_constructors
      runApp(ScholarChat());
    },
  );
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          LogInScreen.iD: (context) => LogInScreen(),
          SignUpScreen.iD: (context) => SignUpScreen(),
          ChatScreen.iD: (context) => ChatScreen(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LogInScreen.iD,
      ),
    );
  }
}
