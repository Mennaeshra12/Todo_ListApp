import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:todo_test/model/task.dart';
import 'package:todo_test/providers/list_provider.dart';
class AddTaskBottomSheet extends StatefulWidget {
 static final formKey = GlobalKey<FormState>()   ;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
 String title = '' ;
 String desc = ' ' ;
 var selectDate = DateTime.now() ;
 late ListProvider listProvider ;

  @override
  Widget build(BuildContext context) {
  listProvider = Provider.of<ListProvider>(context) ;
    return Container(
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task ,
            style:  Theme.of(context).textTheme.bodyMedium,),
            Form(
              key: AddTaskBottomSheet.formKey ,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter task title'
                    ),
                   onChanged: (text){
                      title = text ;

                   },
                   validator: (text){
                      if(text == null || text.isEmpty){
                        return 'Please enter task title' ; // invalid
                      }
                      return null ;   // valid
                    },
                  ),
                ) ,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter task desc' ,
                      errorStyle: TextStyle(
                        color: Colors.red, // Set the error text color to something visible
                      ),
                    ),
                     onChanged: (text){
                      desc = text ;
                     },
                     validator:(text){
                      if(text == null || text.isEmpty){
                        return 'Please enter task desc' ;
                      }
                      return null ;
                    },
                    maxLines: 4,
                  ),
                ),
                Text('Select Date' ,
                style: Theme.of(context).textTheme.bodyMedium,) ,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: (){
                      showCalender() ;
                    },
                    child: Text('${selectDate.day} / ${selectDate.month} / ${selectDate.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  addTask();
    }, child: Text('Add',
                style: Theme.of(context).textTheme.bodyLarge,))
              ],
            ))

          ],
        ),
      ),

    );
  }

 void addTask() {
   if (AddTaskBottomSheet.formKey.currentState?.validate() == true) {
     Task task = Task(
         title: title,
         description: desc,
         dateTime: selectDate
     ) ;
     FirebaseUtils.addTaskToFireStore(task).timeout(Duration(seconds: 1),
     onTimeout: (){
       print('task added successfully');
       listProvider.getAllTasksFromFireStore() ;
       Navigator.pop(context);
     }) ;
   }
     setState(() {
     });

 }


  void showCalender() async {
    var chosenDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now() ,
        lastDate: DateTime.now().add(Duration(days: 365))
    ) ;
    if(chosenDate != null ){
      selectDate = chosenDate  ;
    }
    selectDate = chosenDate ?? selectDate ;
    setState(() {

    });
  }
}


