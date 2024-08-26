import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ThemeBottomSheet extends StatefulWidget {

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
         margin: EdgeInsets.all(15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.appTheme == ThemeMode.light ?
              getSelectedItemWidget(AppLocalizations.of(context)!.light ) :
              getUnSelectedItemWidget(AppLocalizations.of(context)!.light),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.appTheme == ThemeMode.dark ?
              getSelectedItemWidget(AppLocalizations.of(context)!.dark ) :
              getUnSelectedItemWidget(AppLocalizations.of(context)!.dark),
            ),
          ),

        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primaryColor
          ),),
        Icon(Icons.check,size: 30,color: AppColors.primaryColor,)
      ],
    ) ;
  }

  Widget getUnSelectedItemWidget(String text){
    return Text(text,
      style: Theme.of(context).textTheme.bodyMedium,) ;
  }
}
