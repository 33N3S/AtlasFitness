import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool get isLoggedIn {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Method to ensure user is logged in before proceeding
  Future<void> _performActionIfLoggedIn(Future<void> Function() action) async {
    if (isLoggedIn) {
      await action();
    } else {
      throw Exception("User is not logged in");
    }
  }

  Future<void> savePerson(Person person) async {
    await _performActionIfLoggedIn(() async {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _db.collection('users').doc(user.uid).set(person.toMap());
      }
    });
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
      // Set the time component to 00:00:00 to ensure consistency in querying
      DateTime dateOnly = DateTime(dailyIntake.date.year, dailyIntake.date.month, dailyIntake.date.day);

      var dailyIntakeRef = _db.collection('users').doc(user.uid).collection('dailyIntake').doc(dateOnly.toIso8601String());

      var existingDoc = await dailyIntakeRef.get();

      if (existingDoc.exists) {
        // Update the existing document
        var existingIntake = DailyIntake.fromDocumentSnapshot(existingDoc.data());
        var updatedNutrients = Nutrients(
          calories: existingIntake.nutrients.calories + dailyIntake.nutrients.calories,
          protein: existingIntake.nutrients.protein + dailyIntake.nutrients.protein,
          carbs: existingIntake.nutrients.carbs + dailyIntake.nutrients.carbs,
          fats: existingIntake.nutrients.fats + dailyIntake.nutrients.fats,
        );

        await dailyIntakeRef.update({
          'nutrients': updatedNutrients.toMap(),
        });
      } else {
        // Create a new document
        await dailyIntakeRef.set({
          'nutrients': dailyIntake.nutrients.toMap(),
          'date': dateOnly.toIso8601String(),
        });
      }
    }
  }

  Future<void> insertBurnedCalories(DailyIntake burnedCalories) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Set the time component to 00:00:00 to ensure consistency in querying
      DateTime dateOnly = DateTime(burnedCalories.date.year, burnedCalories.date.month, burnedCalories.date.day);

      var burnedCaloriesRef = _db.collection('users')
          .doc(user.uid)
          .collection('burnedCalories')
          .doc(dateOnly.toIso8601String());

      var existingDoc = await burnedCaloriesRef.get();

      if (existingDoc.exists) {
        // Update the existing document
        var existingBurnedCalories = DailyIntake.fromDocumentSnapshot(existingDoc.data());
        var updatedNutrients = Nutrients(
          calories: existingBurnedCalories.nutrients.calories + burnedCalories.nutrients.calories,
          protein: existingBurnedCalories.nutrients.protein + burnedCalories.nutrients.protein,
          carbs: existingBurnedCalories.nutrients.carbs + burnedCalories.nutrients.carbs,
          fats: existingBurnedCalories.nutrients.fats + burnedCalories.nutrients.fats,
        );

        await burnedCaloriesRef.update({
          'nutrients': updatedNutrients.toMap(),
        });
      } else {
        // Create a new document
        await burnedCaloriesRef.set({
          'nutrients': burnedCalories.nutrients.toMap(),
          'date': dateOnly.toIso8601String(),
        });
      }
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

  Future<List<DailyIntake>> getDailyIntakesForCurrentWeek() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get the current date
      DateTime now = DateTime.now();
      // Find the start of the week (assumed to be Monday)
      DateTime startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
      // Find the end of the week (Sunday)
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

      // Format dates to match the Firestore document IDs (which use the date as the ID)
      String startOfWeekStr = startOfWeek.toIso8601String();
      String endOfWeekStr = endOfWeek.toIso8601String();

      // Fetch all dailyIntake documents within this range
      var querySnapshot = await _db
          .collection('users')
          .doc(user.uid)
          .collection('dailyIntake')
          .where('date', isGreaterThanOrEqualTo: startOfWeekStr)
          .where('date', isLessThanOrEqualTo: endOfWeekStr)
          .get();

      // Convert the query result into a list of DailyIntake objects
      List<DailyIntake> dailyIntakes = querySnapshot.docs.map((doc) {
        return DailyIntake.fromDocumentSnapshot(doc.data());
      }).toList();

      // Group by date and get the latest document for each day
      Map<String, DailyIntake> latestIntakes = {};
      for (var intake in dailyIntakes) {
        String dateStr = intake.date.toIso8601String().split('T')[0];
        if (!latestIntakes.containsKey(dateStr) ||
            intake.date.isAfter(latestIntakes[dateStr]!.date)) {
          latestIntakes[dateStr] = intake;
        }
      }

      return latestIntakes.values.toList();
    }

    return [];
  }



Future<List<DailyIntake>> getBurnedCalsForCurrentWeek() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    var querySnapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('burnedCalories')
        .where('date', isGreaterThanOrEqualTo: startOfWeek.toIso8601String())
        .where('date', isLessThanOrEqualTo: endOfWeek.toIso8601String())
        .get();

    List<DailyIntake> burnedCaloriesWeekly = querySnapshot.docs.map((doc) {
      return DailyIntake.fromDocumentSnapshot(doc.data());
    }).toList();

    // Sort the entries by date and keep only the latest entry for each day
    Map<String, DailyIntake> latestIntakes = {};
    for (var intake in burnedCaloriesWeekly) {
      String dateStr = intake.date.toIso8601String().split('T')[0];
      if (!latestIntakes.containsKey(dateStr) ||
          intake.date.isAfter(latestIntakes[dateStr]!.date)) {
        latestIntakes[dateStr] = intake;
      }
    }

    // Convert the map values to a sorted list of DailyIntake objects
    List<DailyIntake> sortedIntakes = latestIntakes.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return sortedIntakes;
  }
  return [];
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

    Future<DailyIntake> getBurnedCaloriesByDate(DateTime date) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var person = Person.fromDocumentSnapshot(doc);

        // Check if there's already an entry for the specified date
        DailyIntake? burnedCalsForDate = person.dailyBurnedCalories.firstWhere(
          (di) => di.date.year == date.year && di.date.month == date.month && di.date.day == date.day,
          orElse: () => DailyIntake(nutrients: Nutrients(calories: 0, protein: 0, carbs: 0, fats: 0), date: date),
        );

        return burnedCalsForDate;
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
        DailyIntake burnedCalsForDate = await getBurnedCaloriesByDate(date);

        // Update the nutrients
        Nutrients updatedNutrients = Nutrients(
          calories: intakeForDate.nutrients.calories - newNutrients.calories,
          protein: intakeForDate.nutrients.protein - newNutrients.protein,
          carbs: intakeForDate.nutrients.carbs - newNutrients.carbs,
          fats: intakeForDate.nutrients.fats - newNutrients.fats,
        );

        Nutrients updatedBurnedCalsNutrients = Nutrients(
          calories: burnedCalsForDate.nutrients.calories + newNutrients.calories,
          protein: burnedCalsForDate.nutrients.protein + newNutrients.protein,
          carbs: burnedCalsForDate.nutrients.carbs + newNutrients.carbs,
          fats: burnedCalsForDate.nutrients.fats + newNutrients.fats,
        );

        // Create or update the intake entry
        DailyIntake updatedIntake = DailyIntake(date: date, nutrients: updatedNutrients);
        DailyIntake updatedBurnedCals = DailyIntake(date: date, nutrients: updatedBurnedCalsNutrients);


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

