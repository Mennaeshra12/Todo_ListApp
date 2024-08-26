import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:todo_test/home/task_list/editTask.dart';
import 'package:todo_test/model/task.dart';
import 'package:todo_test/providers/app_config_provider.dart';
import 'package:todo_test/providers/list_provider.dart';

class TaskListItem extends StatefulWidget {
  Task task ;
  TaskListItem({required this.task}) ;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    var appProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(

        startActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed:(context){
                FirebaseUtils.deleteTaskFormFireStore(widget.task).timeout(
                  Duration(seconds: 1),onTimeout: (){
                    print('task deleted successfully') ;
                    listprovider.getAllTasksFromFireStore();
                }
                ) ;
              } ,
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed:(context){
              showeditscreen(context);
              } ,
              backgroundColor: Color.fromARGB(255, 90, 201, 67),
              foregroundColor: AppColors.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),

          ],
        ),

        child: Container(

          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor ,
            borderRadius:  BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                color: widget.task.isDone ? AppColors.greenColor : Colors.blue,
                height: MediaQuery.of(context).size.height*0.1,
                width: 4,
              ) ,
               Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(widget.task.title,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                             color: widget.task.isDone ? AppColors.greenColor : Colors.blue,
                            ),),
                            Text(widget.task.description ,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: widget.task.isDone ? AppColors.greenColor : Colors.blue,) ),

                          ],
                ),
                    )
                ),

              ElevatedButton(
                onPressed: () async {
                  try {
                    setState(() {
                      widget.task.isDone =
                          !widget.task.isDone; // Toggle completion state in UI
                    });
                    await FirebaseUtils.updateTaskToFireStore(widget.task);
                    listprovider
                      .getAllTasksFromFireStore(); // Refresh tasks list after update
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update task: $e')),
                    );
                  }
                },
                child:widget.task.isDone
                    ? Text(
                        'Done!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(widget.task.isDone
                      ? AppColors.greenColor
                      : AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

     void showeditscreen(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Edittask(
        task: widget.task,
      ),
    );
  
}
}