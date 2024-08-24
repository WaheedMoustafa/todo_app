import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{
  String pref;
  LanguageProvider({required this.pref});

  late String currentLanguage = pref;

  set setNewLanguage(String newLanguage){
    currentLanguage = newLanguage;
    _saveLanguage();
    notifyListeners();
  }

  Future <void> _saveLanguage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Language',currentLanguage);

  }

}