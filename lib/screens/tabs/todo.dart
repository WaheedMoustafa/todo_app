import 'package:flutter/material.dart';
import 'package:todo_app/screens/tabs/update_todo.dart';
import '../../models/todo_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class Todo extends StatelessWidget {
  final TodoDM item;

  const Todo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .13,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        margin: EdgeInsets.symmetric(vertical: 22, horizontal: 26),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Row(
          children: [
            buildVerticalLine(context),
            SizedBox(
              width: 25,
            ),
            buildTodoInfo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTodoState(),
                updateTodo(context),
              ],
            ),
          ],
        ));
  }

  buildVerticalLine(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height * .07,
    width: 4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primary,
    ),
  );

  buildTodoInfo() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Text(
          item.title,
          maxLines: 1,
          style:
          AppStyle.bottomSheetTitle.copyWith(color: AppColors.primary),
        ),
        Spacer(),
        Text(
          item.description,
          style: AppStyle.bodyTextStyle,
        ),
        Spacer(),
      ],
    ),
  );

  buildTodoState() => Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    child: Icon(Icons.done, color: Colors.white, size: 15,),
  );

  updateTodo(BuildContext context) => InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Icon(Icons.edit, color: Colors.white, size: 15,),
    ),
    onTap: (){
      Navigator.of(context).pushNamed(UpdateTodo.routName);
    },
  );

}