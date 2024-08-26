import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_test/app_colors.dart';

typedef MyValidator = String? Function(String?) ;
class CustomerTextFormField extends StatelessWidget{
String label ;
bool obscureText ;
MyValidator validator ;
TextEditingController controller ;
TextInputType keyboardType ;
CustomerTextFormField({required this.label,
  required this.validator ,
  required this.controller ,
  this.keyboardType = TextInputType.text ,
  this.obscureText = false}) ;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
         decoration:  InputDecoration(
           labelText: label ,
           enabledBorder:  OutlineInputBorder(
             borderRadius:  BorderRadius.circular(15) ,
             borderSide: BorderSide(
               color: AppColors.primaryColor
             )
           ) ,
           focusedBorder:  OutlineInputBorder(
               borderRadius:  BorderRadius.circular(15) ,
               borderSide: BorderSide(
                   color: AppColors.primaryColor
               )
           ) ,
           errorBorder:  OutlineInputBorder(
               borderRadius:  BorderRadius.circular(15) ,
               borderSide: BorderSide(
                   color: AppColors.redColor
               )
           ) ,
           focusedErrorBorder: OutlineInputBorder(
               borderRadius:  BorderRadius.circular(15) ,
               borderSide: BorderSide(
                   color: AppColors.redColor
               )
           ) ,
           errorMaxLines: 2
         ),

        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator ,

      ),
    );
  }
}
