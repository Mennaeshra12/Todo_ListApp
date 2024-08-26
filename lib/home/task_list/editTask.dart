import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:todo_test/model/task.dart';
import 'package:todo_test/providers/app_config_provider.dart';
import 'package:todo_test/providers/list_provider.dart';



class Edittask extends StatefulWidget {
  static final formkey = GlobalKey<FormState>();
  final Task
      task; // Add a Task parameter to initialize the screen with existing data

  const Edittask({super.key, required this.task});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  late String title;
  late String description;
  late DateTime selctedDate;
  late ListProvider listprovider;

  @override
  void initState() {
    super.initState();
    // Initialize with existing task data
    title = widget.task.title;
    description = widget.task.description;
    selctedDate = widget.task.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listprovider = Provider.of<ListProvider>(context);
    return Container(
      color: provider.isdarkmode()
          ? AppColors.blackColor
          : AppColors.whiteColor,
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Edit Task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: provider.isdarkmode()
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                )),
            Form(
              key: Edittask.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: title,
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.isdarkmode()
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "This is Title",
                          hintStyle: TextStyle(
                              color: provider.isdarkmode()
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please enter task title";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        title = text;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: description,
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.isdarkmode()
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "Task details",
                          hintStyle: TextStyle(
                              color: provider.isdarkmode()
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please enter task description";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        description = text;
                      },
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Select Time',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: provider.isdarkmode()
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        showcalnder();
                      },
                      child: Text(
                        '${selctedDate.day}/${selctedDate.month}/${selctedDate.year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: provider.isdarkmode()
                                ? Color(0xffDBDBDB)
                                : Color.fromARGB(169, 0, 0, 0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                               MaterialStateProperty.all(AppColors.primaryColor)),
                        onPressed: () {
                          editTaskFunc();
                        },
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showcalnder() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selctedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selctedDate = chosenDate;
      });
    }
  }

  void editTaskFunc() async {
    if (Edittask.formkey.currentState?.validate() == true) {
      Edittask.formkey.currentState?.save();

      // Update the existing Task object with the new data
      Task updatedTask = Task(
        id: widget.task.id, // Ensure you pass the ID to update the correct task
        title: title,
        description: description,
        dateTime: selctedDate,
        isDone: widget.task.isDone, // Maintain the current completion status
      );

      await FirebaseUtils.updateTaskToFireStore(updatedTask)
          .timeout(Duration(seconds: 1), onTimeout: () {
        print('Task edited succesfully');
        listprovider. getAllTasksFromFireStore();
        Navigator.pop(context);
      });
    }
  }
}