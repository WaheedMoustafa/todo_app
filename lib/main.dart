import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      routes: {
        SplashScr.routeName : (_)=>SplashScr(),
        HomeScreen.routeName : (_)=> HomeScreen(),

      },
    );
  }
}



