import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_test/home/task_list/task_list_item.dart';
import 'package:todo_test/providers/list_provider.dart';

import '../../model/task.dart';

class TaskListTab extends StatefulWidget {

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {


  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context) ;
    if(listprovider.taskList.isEmpty) {  // ontime read
     listprovider.getAllTasksFromFireStore();
    }
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              listprovider.changeSelectDate(selectedDate);
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDayAsStrMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ) ,
          Expanded(
            child: listprovider.taskList.isEmpty ? Text('No Tasks Added') :
            ListView.builder(
                itemBuilder: (context , index) {
                  return TaskListItem(task: listprovider.taskList[index] ,) ;

                },
              itemCount: listprovider.taskList.length,
            ),
          )
        ],
      ),

    );
  }


}
