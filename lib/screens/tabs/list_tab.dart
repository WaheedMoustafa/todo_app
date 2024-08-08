import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/tabs/todo.dart';
import 'package:todo_app/utils/date_time_extension.dart';
import '../../models/todo_dm.dart';
import '../../models/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => ListTabState();
}

class ListTabState extends State<ListTab> {
  DateTime selectedCalendarDate = DateTime.now();
  List<TodoDM> todosList = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTodosListFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 75,
          child: ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  //todosList[index].id.toString()
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    height: 365,
                    width: 200,
                    color: Colors.red,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete , color: Colors.white,size: 60,),
                        Text('Delete')
                      ],
                    ),
                  ),
                  confirmDismiss: (direction){
                    return showDialog(context: context,
                        builder: (ctx)=> AlertDialog(
                          content: const Text('Delete this item?'),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(ctx).pop(false);
                            }, child: Text('no')),
                            TextButton(onPressed: (){
                              Navigator.of(ctx).pop(true);
                            }, child: Text('yes'))
                          ],
                        ),
                    );
                  },
                  onDismissed: (direction){
                    deleteTodosListInFireStore();
                    },
                  child: Todo(
                    item: todosList[index],
                  ),
                );
              }),
        ),
      ],
    );
  }

  void getTodosListFromFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();
    todosList = todosList
        .where((todo) =>
    todo.date.year == selectedCalendarDate.year &&
        todo.date.month == selectedCalendarDate.month &&
        todo.date.day == selectedCalendarDate.day)
        .toList();
    setState(() {});
  }


  void deleteTodosListInFireStore() async{
    CollectionReference todosCollection = await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference doc = todosCollection.doc();
    doc.delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );


    setState(() {});
    }


  buildCalendar() {
    return Expanded(
      flex: 25,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                    color: AppColors.primary,
                  )),
              Expanded(
                  child: Container(
                    color: AppColors.bgColor,
                  ))
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            focusDate: selectedCalendarDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            itemBuilder: (context, date, isSelected, onDateTapped) {
              return InkWell(
                onTap: () {
                  selectedCalendarDate = date;
                  getTodosListFromFireStore();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        date.dayName,
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer(),
                      Text(
                        date.day.toString(),
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer()
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}
}