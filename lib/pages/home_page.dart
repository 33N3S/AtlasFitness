import 'package:atlas_fitness/backend/controllers/meal_controller.dart';
import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/controllers/workout_controller.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_bar_chart.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_meal_tile.dart';
import 'package:atlas_fitness/components/my_pie_chart.dart';
import 'package:atlas_fitness/components/my_workout_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final MealService _mealService = MealService();
  final WorkoutService _workoutService = WorkoutService();

  late List<Meal> meals = [];
  late List<Workout> workouts = [];
  late Future<Person?> _userFuture;



  Future<void> _fetchMeals(Person user) async {
    var fetchedMeal = await _mealService.getMealsByTag(user.fitGoal);
    setState(() {
      meals = fetchedMeal;
    });
  }

  Future<void> _fetchWorkouts(Person user) async {
    var fetchedWorkouts = await _workoutService.getWorkoutsByTag(user.fitGoal);
    setState(() {
      workouts = fetchedWorkouts;
    });
  }


  Future<Person?> _getCurrentUser() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService.getPerson();
  }


  @override
  void initState() {
    super.initState();
    _userFuture = _getCurrentUser();

  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,foodBase,child){

      return Scaffold(
      bottomNavigationBar: BottomBar(),
      floatingActionButton: MyFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<Person?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('User not found'));
          } else {
            var user = snapshot.data!;
            // Fetch meals and workouts
            _fetchMeals(user);
            _fetchWorkouts(user);

          return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const HomePageTitle(text: "Daily Tracker"),
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 280,
                  
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PageView(
                    children: [
                      MyPieChart(user: user), 
                      MyBarChart(user: user),
                    ],
                  ),
                ),
        
                
              const HomePageTitle(text: "Suggested Meals"),
        
              Container(
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          var meal = meals[index];
                          return MyMealTile(
                            meal: meal,
                          );
                        },
                  ),
                ),
        
                const SizedBox(height: 15,),
        
                const HomePageTitle(text: "Suggested Workouts"),
                
                Container(
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          var workout = workouts[index];
                          return myWorkoutTile(
                            workout: workout,
                          );
                        },
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
          );}}
    ),
    );
   }) ;   
}
}
