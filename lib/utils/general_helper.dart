

 import 'package:firebase_database/firebase_database.dart';

bool isSameDay(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}

 String generateRandomFirebaseId() {
  DatabaseReference reference = FirebaseDatabase.instance.ref().push();
  return reference.key!;
 }