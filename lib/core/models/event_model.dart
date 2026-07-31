import 'package:flutter/material.dart';

class EventModel {
  static const String collectionName = 'Events';
  String title;
  String id;
  String description;
  DateTime dateTime;
  String time;
  bool isFav;
  String eventCategory;

  EventModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    required this.time,
    this.isFav = false,
    required this.eventCategory,
  });
  Map<String, dynamic> ToFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFav': isFav,
      'eventCategory': eventCategory,
    };
  }

  EventModel.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        time: data['time'],
        isFav: data['isFav'],
        eventCategory: data['eventCategory'],
      );
}
