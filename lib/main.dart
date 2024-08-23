import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/screens/auth/register.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/tabs/update_todo.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDLi66ozmHmv8luBGYtnSRnA_YIo-zJEpk",
        appId: "1:81483740612:android:e2203418080a171680e091",
        messagingSenderId: "todo-app-8b8f3",
        projectId: "todo-app-8b8f3"),
  );
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        Home.routeName: (_) => const Home(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        UpdateTodo.routName : (_) => UpdateTodo(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}