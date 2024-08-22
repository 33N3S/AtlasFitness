import 'dart:io';

import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MealService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get all meals by tag
Future<List<Meal>> getMealsByTag(FitGoals tag) async {
  try {
    // Get the current hour of the day
    final now = DateTime.now();
    final hour = now.hour;

    // Determine the meal category based on the time of day
    MealCategoriesEnum timeBasedCategory;
    if (hour >= 5 && hour < 11) {
      timeBasedCategory = MealCategoriesEnum.Breakfast;
    } else if (hour >= 11 && hour < 17) {
      timeBasedCategory = MealCategoriesEnum.Lunch;
    } else if (hour >= 17 && hour < 22) {
      timeBasedCategory = MealCategoriesEnum.Dinner;
    } else {
      timeBasedCategory = MealCategoriesEnum.Snack; // Default to snacks at night
    }

    // Retrieve meals based on the tag and time-based category
    QuerySnapshot querySnapshot = await _firestore
        .collection('meals')
        .where('tag', isEqualTo: tag.toString())
        .where('category', whereIn: [timeBasedCategory.name, MealCategoriesEnum.Snack.name])
        .get();

    return querySnapshot.docs.map((doc) {
      return Meal.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Error retrieving meals: $e');
    return [];
  }
}



  // Method to insert a meal into Firestore
Future<String> uploadImage(File imageFile, String mealName) async {
  try {
    // Create a reference to the location you want to upload to in Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('meals/$mealName');

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
