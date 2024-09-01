import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/home/auth/login/login_screen.dart';
import 'package:todo_test/home/settings/settings_tab.dart';
import 'package:todo_test/home/task_list/task_list_sheet.dart';
import 'package:todo_test/home/task_list/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_test/providers/list_provider.dart';

import '../providers/user_provider.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context );
    var listProvider = Provider.of<ListProvider>(context );

    return Scaffold(
       appBar: AppBar(
         actions: [
           IconButton(onPressed: (){
             listProvider.taskList = [] ;

             Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
           }, icon: Icon(Icons.logout))
         ],
         toolbarHeight: MediaQuery.of(context).size.height*0.2 ,
         title: Text(
             selectedIndex == 0 ?
             "${AppLocalizations.of(context)!.app_title} {${userProvider.currentUser!.name}}":
                 AppLocalizations.of(context)!.settings ,
         style: Theme.of(context).textTheme.bodyLarge,),

       ),
       bottomNavigationBar: BottomAppBar(
         shape: CircularNotchedRectangle(),
         notchMargin: 12,
         child: BottomNavigationBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
           currentIndex: selectedIndex ,
           onTap: (index){
             selectedIndex = index ;
             setState(() {

             });
           },
           items: [
             BottomNavigationBarItem(
               icon: ImageIcon(AssetImage('assets/tasks.png')),
               label: AppLocalizations.of(context)!.task_list,
             ),
             BottomNavigationBarItem(
               icon: ImageIcon(AssetImage('assets/settings.png')),
               label: AppLocalizations.of(context)!.settings,
             ),

           ],
         ),
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           addTaskBottomSheet();
         },
           backgroundColor:  AppColors.primaryColor ,
           shape: StadiumBorder(
             side: BorderSide(
               color: AppColors.whiteColor ,
               width:  4
             )
           ),


         child:  Icon(Icons.add , size: 35,),

       ),

       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       body: selectedIndex ==0 ? TaskListTab() : SettingsTab (),
    );
  }

  void addTaskBottomSheet() {
  showModalBottomSheet(context: context,
      builder: (context) => AddTaskBottomSheet());
  }

 //  List<Widget> tabs = [TaskListTab(),SettingsTab()] ; => more than one tab
}


