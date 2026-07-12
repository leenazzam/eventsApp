import 'package:events/core/providers/app_language_provider.dart';
import 'package:events/core/providers/app_theme_provider.dart';
import 'package:events/core/utils/app_colors.dart';
import 'package:events/core/widget/event_item_widget.dart';
import 'package:events/core/widget/tab_event_widget.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.metting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.birthday,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
                ),
                Text(
                  'Leen Azzam',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                InkWell(
                  child: Icon(Icons.sunny),
                  onTap: () {
                    final newTheme = themeProvider.appTheme == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                    themeProvider.changeTheme(newTheme);
                  },
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    final newLang = languageProvider.appLanguage == 'en'
                        ? 'ar'
                        : 'en';
                    languageProvider.changeLanguage(newLang);
                  },

                  child: CircleAvatar(
                    radius: 15,
                    child: Text(
                      languageProvider.appLanguage == 'en' ? 'EN' : 'AR',
                    ),
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      'Hebron, Palestine',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                DefaultTabController(
                  length: eventNameList.length,
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    tabs: eventNameList.map((eventName) {
                      return TabEventWidget(
                        eventName: eventName,
                        isSelected:
                            selectedIndex == eventNameList.indexOf(eventName),
                      );
                    }).toList(),
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    tabAlignment: TabAlignment.start,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return EventItemWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
