import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/utils/app_images.dart';



class SplashScr extends StatefulWidget {
  const SplashScr({super.key});
  static const String routeName = 'splash';

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), (){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AppImages.splash),

    );
  }

}
