import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/date_time_extension.dart';
import '../../models/todo_dm.dart';
import '../../models/user_dm.dart';
import '../../utils/app_styles.dart';


class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key});
  static const String routName = 'update';

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 688,
        width: 365,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Edit task",
              textAlign: TextAlign.center,
              style: AppStyle.bottomSheetTitle,
            ),
            TextField(
              decoration: InputDecoration(hintText: "This is title"),
              controller: titleController,
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Task details"),
              controller: descriptionController,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Select date",
              style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16),
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
                  style: AppStyle.normalGreyTextStyle,
                  textAlign: TextAlign.center,
                )),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  updateTodosListInFireStore();
                  Navigator.of(context).pop();
                },
                child: const Text("Save Changes"))
          ],
        ),
      ),
    );
  }

  void updateTodosListInFireStore() async{
    try {
      CollectionReference todosCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.currentUser!.id)
          .collection(TodoDM.collectionName);
      DocumentReference doc = todosCollection.doc();
      await doc.update({
        "title": titleController,
        "description": descriptionController,
        "date": selectedDate,
      });
      print("Document successfully updated!");
    } catch (e) {
      print("Error updating document: $e");
    }
     setState(() {});
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



