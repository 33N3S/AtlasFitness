import 'dart:io';

import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get all meals by tag
Future<List<Workout>> getWorkoutsByTag(FitGoals tag) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('workouts')
        //.where('tag', isEqualTo: tag.toString())
        .get();

    return querySnapshot.docs.map((doc) {
      return Workout.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Error retrieving Workouts: $e');
    return [];
  }
}


  // Method to insert a meal into Firestore
Future<String> uploadImage(File imageFile, String workoutName) async {
  try {
    // Create a reference to the location you want to upload to in Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('meals/$workoutName');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageRef.putFile(imageFile);

    // Wait for the upload to complete
    TaskSnapshot snapshot = await uploadTask;

    // Retrieve the download URL after the upload is complete
    String downloadUrl = await snapshot.ref.getDownloadURL();
    
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return '';
  }
}
}
