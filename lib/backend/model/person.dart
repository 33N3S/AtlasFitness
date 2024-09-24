import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final int age;
  final String sex;
  final double height;
  final double weight;
  final double ratio; // based on the level of daily activity
  double dailyCalNeed;
  double tarGetCalNeed;
  FitGoals fitGoal;
  late Nutrients dailyNeeds;
  List<DailyIntake> dailyIntake;
  List<DailyIntake> dailyBurnedCalories;
  List<Meal> savedMeals;
  List<Meal> customMeals;
  List<Workout> savedWorkouts;
  List<Workout> customWorkouts;



  Person({
    required this.name,
    required this.age,
    required this.sex,
    required this.height,
    required this.weight,
    required this.ratio,
    required this.fitGoal,
    this.dailyCalNeed = 0.0,
    this.tarGetCalNeed = 0.0,
    this.dailyBurnedCalories = const [],
    this.dailyIntake = const [],
    this.savedMeals = const [],
    this.savedWorkouts = const [],
    this.customMeals = const [],
    this.customWorkouts = const []
  }) {
    calculateNeeds();
  }

  void calculateNeeds() {
    dailyCalNeed = calculateDailyCalories();
    tarGetCalNeed = calculateTargetCalories();
    dailyNeeds = calculateDailyNutritionalNeeds(tarGetCalNeed);
  }

  double calculateBMR() {
    if (sex == 'male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double calculateDailyCalories() {
    return calculateBMR() * ratio;
  }

  double calculateTargetCalories() {
    if (fitGoal == FitGoals.gainMuscle) {
      return dailyCalNeed + 500; // Increase 500 calories for muscle gain
    } else if (fitGoal == FitGoals.loseWeight) {
      return dailyCalNeed - 500; // Decrease 500 calories for weight loss
    } else {
      return dailyCalNeed; // Maintain current calories
    }
  }

  Nutrients calculateDailyNutritionalNeeds(double targetCalories) {
    double protein;
    double carbs;
    double fats;

    if (fitGoal == FitGoals.gainMuscle) {
      // 30% protein, 50% carbs, 20% fats
      protein = targetCalories * 0.30 / 4; // 4 calories per gram of protein
      carbs = targetCalories * 0.50 / 4;   // 4 calories per gram of carbs
      fats = targetCalories * 0.20 / 9;    // 9 calories per gram of fats
    } else if (fitGoal == FitGoals.loseWeight) {
      // 40% protein, 40% carbs, 20% fats
      protein = targetCalories * 0.40 / 4;
      carbs = targetCalories * 0.40 / 4;
      fats = targetCalories * 0.20 / 9;
    } else {
      // Example macronutrient distribution for maintenance:
      // 30% protein, 50% carbs, 20% fats
      protein = targetCalories * 0.30 / 4;
      carbs = targetCalories * 0.50 / 4;
      fats = targetCalories * 0.20 / 9;
    }

    return Nutrients(
      calories: targetCalories,
      protein: protein,
      carbs: carbs,
      fats: fats,
    );
  }

  //--------------- Serialization ---------------

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'sex': sex,
      'height': height,
      'weight': weight,
      'ratio': ratio,
      'dailyCalNeed': dailyCalNeed,
      'tarGetCalNeed': tarGetCalNeed,
      'fitGoal': fitGoal.toString().split('.').last,
      'dailyNeeds': dailyNeeds.toMap(),
      'dailyIntake': dailyIntake.map((di) => di.toMap()).toList(),
      'savedMeals': savedMeals.map((meal) => meal.toMap()).toList(),
      'customMeals': customMeals.map((meal) => meal.toMap()).toList(),
      'savedWorkouts': savedWorkouts.map((workout) => workout.toMap()).toList(),
      'customWorkouts': customWorkouts.map((workout) => workout.toMap()).toList(),
      'dailyBurnedCalories': dailyBurnedCalories.map((dbc)=>dbc.toMap()).toList()
    };
  }

  factory Person.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Person(
      name: data['name'],
      age: data['age'],
      sex: data['sex'],
      height: data['height'],
      weight: data['weight'],
      ratio: data['ratio'],
      fitGoal: FitGoals.values.firstWhere((e) => e.toString() == 'FitGoals.' + data['fitGoal']),
      dailyIntake: (data['dailyIntake'] as List<dynamic>)
          .map((di) => DailyIntake.fromDocumentSnapshot(di))
          .toList(),
      dailyBurnedCalories: (data['dailyBurnedCalories'] as List<dynamic>)
          .map((dbc) => DailyIntake.fromDocumentSnapshot(dbc))
          .toList(),
      savedMeals: (data['savedMeals'] as List<dynamic>)
          .map((meal) => Meal.fromMap(meal))
          .toList(),
      customMeals: (data['customMeals'] as List<dynamic>)
          .map((meal) => Meal.fromMap(meal))
          .toList(),
      savedWorkouts: (data['savedWorkouts'] as List<dynamic>)
          .map((workout) => Workout.fromMap(workout))
          .toList(),
      customWorkouts: (data['customWorkouts'] as List<dynamic>)
          .map((workout) => Workout.fromMap(workout))
          .toList(),
          
    )
      ..dailyCalNeed = data['dailyCalNeed']
      ..tarGetCalNeed = data['tarGetCalNeed']
      ..dailyNeeds = Nutrients.fromMap(data['dailyNeeds']);
  }
}
