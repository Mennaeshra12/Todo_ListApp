import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> taskList= [];
  var selectDate = DateTime.now() ;
  void getAllTasksFromFireStore(String uId) async {

    var querySanpshot = await FirebaseUtils.getTasksCollection(uId).get();
    taskList = querySanpshot.docs.map((doc) {
      return doc.data();
    }).toList();


   taskList = taskList.where((task) {
      if(selectDate.day == task.dateTime.day &&
      selectDate.month == task.dateTime.month &&
      selectDate.year == task.dateTime.year){
        return true ;
      }
      return false ;
    }).toList();


     taskList.sort((task1 , task2) {
       return task1.dateTime.compareTo(task2.dateTime) ;
     });

    notifyListeners();
  }

  void changeSelectDate (DateTime newDate , String uId){
    selectDate =newDate ;
    getAllTasksFromFireStore(uId) ;

  }
}