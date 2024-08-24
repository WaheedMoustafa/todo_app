import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/extension.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/date_time_extension.dart';
import '../../models/todo_dm.dart';
import '../../models/user_dm.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_styles.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddBottomSheet(),
          );
        });
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late LanguageProvider languageProvider ;
  late ThemeProvider themeProvider ;
  @override
  Widget build(BuildContext context) {
    languageProvider= Provider.of(context);
    themeProvider =Provider.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            context.appLocalizations.new_task,
            textAlign: TextAlign.center,
            style: AppStyle.bottomSheetTitle.copyWith(
                color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
          ),
          TextField(
            style: TextStyle(color: themeProvider.isDarkThemeEnabled? AppColors.white : AppColors.black),
            decoration: InputDecoration(hintText: context.appLocalizations.task_title
                ,hintStyle: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white54 :AppColors.black),
          ),
            controller: titleController,
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            style: TextStyle(color: themeProvider.isDarkThemeEnabled? AppColors.white : AppColors.black),

            decoration: InputDecoration(
                hintText: context.appLocalizations.task_description,
              hintStyle: TextStyle(color: themeProvider.isDarkThemeEnabled? Colors.white54:AppColors.black),

            ),
            controller: descriptionController,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            context.appLocalizations.selectDate,
            style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16,
                color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate,
                style: AppStyle.normalGreyTextStyle.copyWith(
                    color: themeProvider.isDarkThemeEnabled? Colors.white:AppColors.black),
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addTodoToFireStore();
              },
              child:  Text(context.appLocalizations.add))
        ],
      ),
    );
  }

  void addTodoToFireStore() {
    CollectionReference todosCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference doc = todosCollection.doc();
    TodoDM todoDM = TodoDM(
        id: doc.id,
        title: titleController.text,
        date: selectedDate,
        description: descriptionController.text,
        isDone: false);
    doc.set(todoDM.toJson()).then((_) {
      ///This callback is called when future is completed
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      /// This callback is called when the throws an exception
    }).timeout(const Duration(milliseconds: 500), onTimeout: () {
      /// This callback is called after duration you've in first argument
    });
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}