import 'package:ameen/model/student.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/parent.dart';
import '../model/school.dart';
import 'data_converter.dart';

class DatabaseHelper {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.ref();

  Future<String?> save<T extends ToMapConvertible>(
      T model, String refName) async {
    try {
      print("Is being save");
      DatabaseReference newModelRef = _rootRef.child(refName).push();
      String modelId = newModelRef.key ?? '';

      if (model is ParentModel) {
        model.id = modelId!;
      } else if (model is StudentModel) {
        model.id = modelId!;
      }
      await newModelRef.set(model.toMap());

      print('${T.toString()} saved successfully with ID: $modelId');
      return modelId;
    } catch (error) {
      print('Error saving ${T.toString()}: $error');
      return null;
    }
  }

  Future<List<SchoolModel>> getAllSchools() async {
    try {
      final snapshot = await _rootRef.child('schools').get();
      return snapshot.children
          .map((child) => SchoolModel.fromSnapshot(child))
          .toList();
    } catch (error) {
      print('Error getting schools: $error');
      return [];
    }
  }
}
