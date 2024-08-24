import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/extension.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

import '../../utils/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late LanguageProvider languageProvider ;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return SafeArea(
        child: Scaffold(
          body: Column(
              children:[
              Container(
                color: AppColors.primary,
                height: 71,),
              Column(
                children: [
                  const SizedBox(height: 25,),
                  Text(context.appLocalizations.language,
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,color: themeProvider.isDarkThemeEnabled? Colors.white :AppColors.black),),
                  const SizedBox(height: 20,),
                  Container(
                    height: 48,
                    width: 319,
                    color:  themeProvider.isDarkThemeEnabled? AppColors.black:Colors.white,
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: themeProvider.isDarkThemeEnabled? AppColors.black:Colors.white,
                        value: languageProvider.currentLanguage,
                        padding: const EdgeInsets.all(10),
                        underline: const SizedBox(),
                        style: TextStyle(color: AppColors.primary),
                        items: [
                          DropdownMenuItem(
                              value: 'en',
                              child: Text(context.appLocalizations.english,style: TextStyle(color: AppColors.primary),)),
                          DropdownMenuItem(
                              value: 'ar',
                              child: Text(context.appLocalizations.arabic)),
                        ],
                        onChanged: (newValue){
                          languageProvider.setNewLanguage = newValue??  languageProvider.currentLanguage ;
                          setState(() {
                          });
                        }

                    ),
                  ),
                  const SizedBox(height: 20,),

                  Text(context.appLocalizations.mode,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700 ,
                          color: themeProvider.isDarkThemeEnabled? Colors.white :AppColors.black)),
                  const SizedBox(height: 20,),
                  Container(
                    height: 48,
                    width: 319,
                    color:  themeProvider.isDarkThemeEnabled? AppColors.black:Colors.white,
                    child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: themeProvider.isDarkThemeEnabled? AppColors.black:Colors.white,
                        value: themeProvider.currentThemeMode,
                        padding: const EdgeInsets.all(10),
                        underline: const SizedBox(),
                        style: TextStyle(color: AppColors.primary),
                        items: [
                          DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text(context.appLocalizations.dark,style: TextStyle(color: AppColors.primary),)),
                          DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text(context.appLocalizations.light,style: TextStyle(color: AppColors.primary))),
                        ],
                        onChanged: (newValue){
                          themeProvider.newTheme =  newValue?? themeProvider.currentThemeMode  ;
                          setState(() {
                          });
                        }

                    ),
                  ),


                ],
              ),
            ]

          ),
        ));
  }
}
