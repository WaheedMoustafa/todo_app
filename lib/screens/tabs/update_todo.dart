import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/date_time_extension.dart';
import '../../models/todo_dm.dart';
import '../../models/user_dm.dart';
import '../../utils/app_styles.dart';
import '../../utils/args.dart';
import '../home.dart';
import 'list_tab.dart';


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
    ModalRoute moudalRoute = ModalRoute.of(context)!;
    arg arguments = moudalRoute.settings.arguments! as arg ;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Edit List'),
          backgroundColor: AppColors.primary,
        ),
        body: Stack(
          children: [
            Container(
              color: AppColors.primary,
            height: 71,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                height: 688,
                width: 352,
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
                    SizedBox(
                      height: 52,
                      width: 255,
                      child: ElevatedButton(
                          onPressed: () {

                              updateTodosListInFireStore(arguments.idUpdate);
                              Navigator.of(context).pushReplacementNamed( Home.routeName);
                              arguments.fun;



                          },
                          child: const Text("Save Changes"),
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                            ),

                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void updateTodosListInFireStore(String id) async{
      CollectionReference todosCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.currentUser!.id)
          .collection(TodoDM.collectionName);
      DocumentReference doc = todosCollection.doc(id);
      doc.update({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "date": selectedDate,
      });
      print("Document successfully updated!");
      setState(() {

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



