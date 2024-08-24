import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/extension.dart';
import 'package:todo_app/providers/theme_provider.dart';
import '../../models/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/constant.dart';
import '../../utils/dialog_utils.dart';
import '../home.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String username = "";
   late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
      themeProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text(context.appLocalizations.register),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                style: TextStyle(color: themeProvider.isDarkThemeEnabled? AppColors.white:AppColors.black),
                onChanged: (text) {
                  username = text;
                },
                decoration:  InputDecoration(
                  label: Text(
                    context.appLocalizations.userName,
                    style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                  ),
                ),
              ),
              TextFormField(
                style: TextStyle(color: themeProvider.isDarkThemeEnabled? AppColors.white:AppColors.black),
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
                style: TextStyle(color: themeProvider.isDarkThemeEnabled? AppColors.white:AppColors.black),
                onChanged: (text) {
                  password = text;
                },
                decoration:  InputDecoration(
                  label: Text(
                    context.appLocalizations.pass,
                    style: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child:  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          context.appLocalizations.createAccount,
                          style: TextStyle(fontSize: 18,color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      showLoading(context);
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserDM.currentUser =
          UserDM(id: credential.user!.uid, email: email, userName: username);
      registerUserInFireStore(UserDM.currentUser!);
      if (context.mounted) {
        hideLoading(context);
        Navigator.pushNamed(context, Home.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      String message;
      if (authError.code == context.appLocalizations.weak_password) {
        message =  context.appLocalizations.thePasswordProvidedIsTooWeak;
      } else if (authError.code ==  context.appLocalizations.email_already_in_use) {
        message =  context.appLocalizations.theAccountAlreadyExistsForThatEmail;
      } else {
        message = Constants.defaultErrorMessage;
      }
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: context.appLocalizations.error, body: message, posButtonTitle:  context.appLocalizations.ok);
      }
    } catch (e) {
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: context.appLocalizations.error,
            body: Constants.defaultErrorMessage,
            posButtonTitle: context.appLocalizations.ok);
      }
    }
  }

  void registerUserInFireStore(UserDM user) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference newUserDoc = collectionReference.doc(user.id);
    await newUserDoc.set(user.toJson());
  }
}