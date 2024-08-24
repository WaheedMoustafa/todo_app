import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/extension.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/auth/register.dart';
import '../../models/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/constant.dart';
import '../../utils/dialog_utils.dart';
import '../home.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text(context.appLocalizations.login),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  context.appLocalizations.welcomeBack,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                onChanged: (text) {
                  email = text;
                },
                decoration:  InputDecoration(
                  label: Text(
                    context.appLocalizations.email,
                    style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                onChanged: (text) {
                  password = text;
                },
                obscureText: true,
                decoration:  InputDecoration(
                  label: Text(
                    context.appLocalizations.pass,
                    style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child:  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          context.appLocalizations.login,
                          style: TextStyle(fontSize: 18,
                              color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child:  Text(
                 context.appLocalizations.createAccount,
                  style: TextStyle(fontSize: 18,
                      color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserDM.currentUser = await getUserFromFirestore(credential.user!.uid);
      if (context.mounted) {
        hideLoading(context);
        Navigator.pushNamed(context, Home.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      String message;
      print("FirebaseAuthException: ${authError.code}");
      if (authError.code == 'invalid-credential') {
        message = "Double your email or password and try again!";
      } else {
        message = Constants.defaultErrorMessage;
      }
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: "Error", body: message, posButtonTitle: "ok");
      }
    } catch (e, stackTrace) {
      print("Catching error: ${e} - $stackTrace");
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: "Error",
            body: Constants.defaultErrorMessage,
            posButtonTitle: "ok");
      }
    }
  }

  Future<UserDM> getUserFromFirestore(String id) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDoc = collectionReference.doc(id);
    DocumentSnapshot userSnapshot = await userDoc.get();
    return UserDM.fromJson(userSnapshot.data() as Map<String, dynamic>);
  }
}