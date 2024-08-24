import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/screens/auth/register.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/splash.dart';
import 'package:todo_app/screens/tabs/update_todo.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themPref =    prefs.getBool('Mode') ?? false ;
  String langPref =  prefs.getString('Language') ?? 'en';

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDLi66ozmHmv8luBGYtnSRnA_YIo-zJEpk",
        appId: "1:81483740612:android:e2203418080a171680e091",
        messagingSenderId: "todo-app-8b8f3",
        projectId: "todo-app-8b8f3"),
  );
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
      ChangeNotifierProvider(
    create: (context)=>ThemeProvider(pref: themPref),
    child: ChangeNotifierProvider(
        create: (context)=> LanguageProvider(pref: langPref),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    LanguageProvider languageProvider = Provider.of(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(languageProvider.currentLanguage),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.currentThemeMode,
      debugShowCheckedModeBanner: false,
      routes: {
        Home.routeName: (_) => const Home(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        UpdateTodo.routName : (_) => UpdateTodo(),
        SplashScr.routeName:(_)=>SplashScr(),
      },
      initialRoute: SplashScr.routeName,
    );
  }
}