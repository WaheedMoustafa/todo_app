import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/app_images.dart';
import 'auth/login.dart';



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
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } );
  }
  late ThemeProvider themeProvider ;
  late LanguageProvider languageProvider ;

  @override

  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    languageProvider = Provider.of(context);
    return Scaffold(
      body: Image.asset(themeProvider.isDarkThemeEnabled? AppImages.darkSplash:AppImages.splash),

    );
  }

}
