import 'package:events/core/utils/app_colors.dart';
import 'package:events/core/widget/custom_text_field.dart';
import 'package:events/core/widget/event_item_widget.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        children: [
          CustomTextField(
            controller: searchController,
            hintText: AppLocalizations.of(context)!.searchForEvent,
            prefixIcon: Icon(Icons.search, color: AppColors.primaryLight),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
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
