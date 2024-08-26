import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:todo_test/model/task.dart';
import 'package:todo_test/providers/list_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task ;
  TaskListItem({required this.task}) ;


  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(

        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed:(context){
                FirebaseUtils.deleteTaskFormFireStore(task).timeout(
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

                color: AppColors.primaryColor,
                height: MediaQuery.of(context).size.height*0.1,
                width: 4,
              ) ,
               Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(task.title,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor
                            ),),
                            Text(task.description ,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.blackColor) , ),

                          ],
                ),
                    )
                ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 3 ),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor ,
                    borderRadius:  BorderRadius.circular(15)
                ),
                child: Icon(Icons.check , size:  30 , color: AppColors.whiteColor, ),

              )
            ],
          ),

        ),
      ),
    ) ;
  }
}
