import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/home/settings/language_bottom_sheet.dart';
import 'package:todo_test/home/settings/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_test/providers/app_config_provider.dart';

class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context) ;
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.appTheme == ThemeMode.dark ? AppColors.redColor:AppColors.whiteColor,
              border: Border.all(
                color: AppColors.primaryColor
              )
            ),
            child: InkWell(
              onTap: (){
                showLanguageBotttomSheet();

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( provider.appLanguage == 'en' ?
                    AppLocalizations.of(context)!.english:
                  AppLocalizations.of(context)!.arabic
                    , style: Theme.of(context).textTheme.bodyMedium,),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),

          SizedBox(height: 15,),
          Text(AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: provider.appTheme == ThemeMode.dark ? AppColors.redColor:AppColors.whiteColor,
                border: Border.all(
                    color: AppColors.primaryColor
                )
            ),
            child: InkWell(
              onTap: (){
                    showThemeBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appTheme == ThemeMode.dark ?
                    AppLocalizations.of(context)!.dark :
                    AppLocalizations.of(context)!.light
                    , style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  void showLanguageBotttomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet()
    ) ;
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeBottomSheet()
    ) ;



  }
}
