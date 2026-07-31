import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/models/event_model.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromFireStore(snapshot.data()!),
          toFirestore: (event, _) => event.ToFireStore(),
        );
  }

  static Future<void> addEventsToFirebaseStore(EventModel event) {
    var collectionRef = getEventCollection();
    var docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
