import 'package:flutter/material.dart';
import 'package:todo_app/screens/tabs/update_todo.dart';
import '../../models/todo_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class Todo extends StatefulWidget {
  final TodoDM item;

  const Todo({super.key, required this.item});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
   bool isDone = false  ;

  @override

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .13,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        margin:  const EdgeInsets.symmetric(vertical: 22, horizontal: 26),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Row(
          children: [
            buildVerticalLine(context,isDone),
            const SizedBox(
              width: 25,
            ),
            buildTodoInfo(isDone),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: isDone == false? AppColors.primary : Colors.white
                  ),
                  child: isDone ==false ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary ,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child:  const Icon(Icons.done, color: Colors.white, size: 15,),
                  ) :  Container(
                    color: Colors.white,
                    child: const Text('Done !',
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.green),),
                  ),
                onPressed: (){
                    if(isDone == false){
                  isDone = !isDone ;
                setState(() {
          });
                    }
          },

                  //
    )
              ],
            ),
          ],
        ));
  }

  buildVerticalLine(BuildContext context , bool isDone) => Container(
    height: MediaQuery.of(context).size.height * .07,
    width: 4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: isDone == false ? AppColors.primary : Colors.green ,
    ),
  );

  buildTodoInfo( bool isDone) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Text(
          widget.item.title,
          maxLines: 1,
          style:
          AppStyle.bottomSheetTitle.copyWith(color: isDone == false ? AppColors.primary :Colors.green ),
        ),
        Spacer(),
        Text(
          widget.item.description,
          style: AppStyle.bodyTextStyle,
        ),
        Spacer(),
      ],
    ),
  );



  buildTodoState() => ElevatedButton(
    onPressed: (){
      },

    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primary ,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: const Icon(Icons.done, color: Colors.white, size: 15,),
    ),
  //
  );


}