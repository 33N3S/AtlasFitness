import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savePerson(Person person) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db.collection('users').doc(user.uid).set(person.toMap());
    }
  }

  Future<void> updatePerson(Map<String, dynamic> data) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db.collection('users').doc(user.uid).update(data);
    }
  }

  Future<Person?> getPerson() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return Person.fromDocumentSnapshot(doc);
      }
    }
    return null;
  }

  Future<void> insertDailyIntake(DailyIntake dailyIntake) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db.collection('users').doc(user.uid).collection('dailyIntake').doc(dailyIntake.date.toIso8601String()).set(dailyIntake.toMap());
    }
  }

  Future<void> insertCustomMeal(Meal meal) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if a meal with the same name already exists
        var existingMealIndex = person.customMeals.indexWhere((m) => m.name == meal.name);
        if (existingMealIndex != -1) {
          // Replace the existing meal with the new one
          person.customMeals[existingMealIndex] = meal;
        } else {
          // Add the new meal to the custom meals list
          person.customMeals.add(meal);
        }

        // Save the updated person data
        await savePerson(person);
      }
    }
  }


  Future<void> saveMeal(Meal meal) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if a meal with the same name already exists
        var existingMealIndex = person.savedMeals.indexWhere((m) => m.name == meal.name);
        if (existingMealIndex != -1) {
          // Replace the existing meal with the new one
          person.savedMeals[existingMealIndex] = meal;
        } else {
          // Add the new meal to the custom meals list
          person.savedMeals.add(meal);
        }

        // Save the updated person data
        await savePerson(person);
      }
    }
  }


  Future<void> unsaveMeal(Meal meal) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if the meal exists in the savedMeals list
        var savedMealIndex = person.savedMeals.indexWhere((m) => m.name == meal.name);
        if (savedMealIndex != -1) {
          person.savedMeals.removeAt(savedMealIndex);
        } else {
          // If not found in savedMeals, check the customMeals list
          var customMealIndex = person.customMeals.indexWhere((m) => m.name == meal.name);
          if (customMealIndex != -1) {
            person.customMeals.removeAt(customMealIndex);
          }
        }

        // Save the updated person data
        await savePerson(person);
      }
    }
  }


  Future<void> saveWorkout(Workout workout) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if a meal with the same name already exists
        var existingIndex = person.savedWorkouts.indexWhere((w) => w.name == workout.name);
        if (existingIndex != -1) {
          // Replace the existing meal with the new one
          person.savedWorkouts[existingIndex] = workout;
        } else {
          // Add the new meal to the custom meals list
          person.savedWorkouts.add(workout);
        }
        // Save the updated person data
        await savePerson(person);
      }
    }
  }

  
  Future<void> unsaveWorkout(Workout workout) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if the workout exists in the savedWorkouts list
        var savedWorkoutIndex = person.savedWorkouts.indexWhere((w) => w.name == workout.name);
        if (savedWorkoutIndex != -1) {
          person.savedWorkouts.removeAt(savedWorkoutIndex);
        } else {
          // If not found in savedWorkouts, check the customWorkouts list
          var customWorkoutIndex = person.customWorkouts.indexWhere((w) => w.name == workout.name);
          if (customWorkoutIndex != -1) {
            person.customWorkouts.removeAt(customWorkoutIndex);
          }
        }

        // Save the updated person data
        await savePerson(person);
      }
    }
  }


  Future<void> insertCustomWorkout(Workout workout) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if a meal with the same name already exists
        var existingWorkoutIndex = person.customWorkouts.indexWhere((w) => w.name == workout.name);
        if (existingWorkoutIndex != -1) {
          // Replace the existing meal with the new one
          person.customWorkouts[existingWorkoutIndex] = workout;
        } else {
          // Add the new meal to the custom meals list
          person.customWorkouts.add(workout);
        }

        // Save the updated person data
        await savePerson(person);
      }
    }
  }

  Future<DailyIntake> getIntakeByDate(DateTime date) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if there's already an entry for the specified date
        DailyIntake? intakeForDate = person.dailyIntake.firstWhere(
          (di) => di.date.year == date.year && di.date.month == date.month && di.date.day == date.day,
          orElse: () => DailyIntake(nutrients: Nutrients(calories: 0, protein: 0, carbs: 0, fats: 0), date: date),
        );

        return intakeForDate;
      }
    }
    // Handle cases where the user is not found or logged in
    return DailyIntake(date: date, nutrients: Nutrients(calories: 0, protein: 0, carbs: 0, fats: 0));
  }

  Future<void> updateDailyIntakeNutrients(DateTime date, Nutrients newNutrients) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Fetch the intake for the specified date
        DailyIntake intakeForDate = await getIntakeByDate(date);

        // Update the nutrients
        Nutrients updatedNutrients = Nutrients(
          calories: intakeForDate.nutrients.calories + newNutrients.calories,
          protein: intakeForDate.nutrients.protein + newNutrients.protein,
          carbs: intakeForDate.nutrients.carbs + newNutrients.carbs,
          fats: intakeForDate.nutrients.fats + newNutrients.fats,
        );

        // Create or update the intake entry
        DailyIntake updatedIntake = DailyIntake(date: date, nutrients: updatedNutrients);

        // Save the updated intake to Firestore
        await insertDailyIntake(updatedIntake);

        // Update the local list if needed
        var index = person.dailyIntake.indexWhere(
          (di) => di.date.year == date.year && di.date.month == date.month && di.date.day == date.day,
        );
        if (index != -1) {
          person.dailyIntake[index] = updatedIntake;
        } else {
          person.dailyIntake.add(updatedIntake);
        }
        await savePerson(person); // Save the updated person data if needed
      }
    }
  }

    Future<void> updateDailyIntakeWorkout(DateTime date, Nutrients newNutrients) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Fetch the intake for the specified date
        DailyIntake intakeForDate = await getIntakeByDate(date);

        // Update the nutrients
        Nutrients updatedNutrients = Nutrients(
          calories: intakeForDate.nutrients.calories - newNutrients.calories,
          protein: intakeForDate.nutrients.protein - newNutrients.protein,
          carbs: intakeForDate.nutrients.carbs - newNutrients.carbs,
          fats: intakeForDate.nutrients.fats - newNutrients.fats,
        );

        // Create or update the intake entry
        DailyIntake updatedIntake = DailyIntake(date: date, nutrients: updatedNutrients);

        // Save the updated intake to Firestore
        await insertDailyIntake(updatedIntake);

        // Update the local list if needed
        var index = person.dailyIntake.indexWhere(
          (di) => di.date.year == date.year && di.date.month == date.month && di.date.day == date.day,
        );
        if (index != -1) {
          person.dailyIntake[index] = updatedIntake;
        } else {
          person.dailyIntake.add(updatedIntake);
        }
        await savePerson(person); // Save the updated person data if needed
      }
    }
  }
}

