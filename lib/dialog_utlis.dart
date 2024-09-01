import 'package:flutter/material.dart';

class DialogUtlis{
  static void showLoading({required BuildContext context , required String loadingLabel , bool barrierDismissible= true}) {
    showDialog(
      barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator() ,
            SizedBox(width: 10,) ,
            Text(loadingLabel ,
            style:  Theme.of(context).textTheme.bodyMedium,) ,

          ],
        ),
      );
        }
    ) ;
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage({required BuildContext context ,required String message ,
    String title = '' ,
  String? posActionName ,
    Function? posAction ,
    String? negActionName ,
    Function? negAction
  }){
   List<Widget> actions = [] ;
   if(posActionName != null){
     actions.add(ElevatedButton(onPressed: (){
       Navigator.pop(context);
       posAction?.call();
     }, child: Text(posActionName)));
   }
   if(negActionName != null){
     actions.add(ElevatedButton(onPressed: (){
       Navigator.pop(context);
       negAction?.call();
     }, child: Text(negActionName))) ;
   }
    showDialog(context: context,
        builder: (context){
         return AlertDialog(
           content: Text(message,
             style:  Theme.of(context).textTheme.bodyMedium,),
           title: Text(title) ,
           actions: actions,
         );
        }
        );
  }



}