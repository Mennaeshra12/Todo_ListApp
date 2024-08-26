
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_test/app_colors.dart';

class MyThemeData{

  static final ThemeData lightTheme =  ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                  color: AppColors.primaryColor ,
                  width: 2
              )
          )
      ),
      primaryColor: AppColors.primaryColor ,
      scaffoldBackgroundColor: AppColors.blackGroundLightColor ,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor ,
        elevation: 0
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor ,
        showUnselectedLabels: false ,
      ),
      textTheme: TextTheme(
        bodyLarge:  GoogleFonts.poppins(
          fontSize:  22 ,
          fontWeight:  FontWeight.bold ,
          color: AppColors.whiteColor
        )

  )
  );

  static final ThemeData darkTheme =  ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                  color: AppColors.primaryColor ,
                  width: 2
              )
          )
      ),
      primaryColor: AppColors.primaryColor ,
      scaffoldBackgroundColor: AppColors.blackGroundDarkColor ,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor ,
          elevation: 0
      ),

      textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
              fontSize:  22 ,
              fontWeight:  FontWeight.bold ,
              color: AppColors.blackDarkColor
          )

      )
  );


}