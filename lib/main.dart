
import 'package:atlas_fitness/backend/controllers/meal_controller.dart';
import 'package:atlas_fitness/backend/controllers/workout_controller.dart';
import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_base.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/backend/model/workout_base.dart';
import 'package:atlas_fitness/firebase_options.dart';
import 'package:atlas_fitness/pages/welcome_page.dart';
import 'package:atlas_fitness/themes/dark_theme.dart';
import 'package:atlas_fitness/themes/light_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  await insertFoodItems();
  await insertWorkoutItems();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>FoodBase())
  ],
  child: MainApp()
  ));
}

Future<void> insertFoodItems() async {
  MealService mealService = MealService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Meal> mealItems = MealBase.mealList;

  for (var meal in mealItems) {
    // File imageFile = File('C:/flutter apps/atlas_fitness/lib/images/meals_images/${meal.imagePath}');

    // String imageUrl = await mealService.uploadImage(imageFile, meal.imagePath.substring(0,5));
    // meal.imageUrl = imageUrl;

    var mealRef = firestore.collection('meals').doc(meal.name); // Use name as document ID
    await mealRef.set(meal.toMap());
  }

}

Future<void> insertWorkoutItems() async{
  WorkoutService workoutService = WorkoutService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Workout> workoutItems = WorkoutBase.workouts;

  for(var workout in workoutItems){
    var workoutRef = firestore.collection('workouts').doc(workout.name);
    await workoutRef.set(workout.toMap());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,                          
      theme: lightMode,  // Apply the light theme
      darkTheme: darkMode,  // Apply the dark theme
      themeMode: ThemeMode.system,  
      home: WelcomePage(),
    );
  }
}

