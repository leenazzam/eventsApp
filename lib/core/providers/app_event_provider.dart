import 'package:flutter/material.dart';
import 'package:events/core/models/event_model.dart';
import 'package:events/core/utils/firebase_utils.dart';

class EventProvider extends ChangeNotifier {
  Future<void> updateFavorite(EventModel event) async {
    event.isFav = !event.isFav;
    await FirebaseUtils.updateEvent(event);
    notifyListeners();
  }

  Future<void> deleteEvent(String id) async {
    await FirebaseUtils.deleteEvent(id);
    notifyListeners();
  }
}
