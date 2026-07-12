import 'package:events/core/providers/app_language_provider.dart';
import 'package:events/core/providers/app_theme_provider.dart';
import 'package:events/core/utils/app_colors.dart';
import 'package:events/core/widget/tab_event_widget.dart';
import 'package:events/core/widget/custom_text_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int selectedIndex = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
      appBar: AppBar(title: Text('Create Event'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                  image: DecorationImage(
                    image: AssetImage('assets/image/birthday.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
                      color: AppColors.primaryLight,
                      selectedTextColor: AppColors.whiteColor,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: TextStyle(color: AppColors.blackColor, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    prefixIcon: Icon(Icons.edit_note),
                    controller: titleController,
                    hintText: AppLocalizations.of(context)!.eventTitle,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context)!.eventDescription,

                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );
                      if (date != null) setState(() => selectedDate = date);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: AppColors.blackColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.eventDate,

                              style: TextStyle(color: AppColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          selectedDate == null
                              ? AppLocalizations.of(context)!.chooseDate
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: TextStyle(color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) setState(() => selectedTime = time);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.blackColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.eventTime,
                              style: TextStyle(color: AppColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          selectedTime == null
                              ? AppLocalizations.of(context)!.chooseTime
                              : selectedTime!.format(context),
                          style: TextStyle(color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.chooseEventLocation,
                    color: AppColors.primaryLight,
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primaryLight,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.addEvent,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
