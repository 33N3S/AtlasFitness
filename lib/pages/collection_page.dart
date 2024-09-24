import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/helpers/displayDialogMessage.dart';
import 'package:atlas_fitness/pages/meal_details_page.dart';
import 'package:atlas_fitness/pages/workout_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late Future<Person?> _userFuture;

  Future<Person?> _getCurrentUser() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService.getPerson();
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _getCurrentUser();
  }

  // Method to build rows for each ExpansionTile
  Widget _buildMealRows(List<Meal> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Theme.of(context).colorScheme.surface,
              endIndent: 20,
              indent: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetails(meal: item),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            item.category.toString().split('.').last,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteMeal(item);
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  Widget _buildWorkoutRows(List<Workout> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Column(
          children: [
            Divider(
              color: Theme.of(context).colorScheme.surface,
              endIndent: 20,
              indent: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetails(workout: item),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            item.type.toString().split('.').last,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteWorkout(item);
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

Future<void> _deleteWorkout(Workout workout) async {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
    try{
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.unsaveWorkout(workout);
    setState(() {
    });
    //pop the loading circle
    Navigator.pop(context);
    
    setState(() {
      _userFuture = _getCurrentUser();
    });

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Workout Removed from collection',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 2),
    ),
    );
    }on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayDialogMessage(e.code, context);
  }
  }

  Future<void> _deleteMeal(Meal meal) async {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    FirestoreService firestoreService = FirestoreService();
    await firestoreService.unsaveMeal(meal);
    setState(() {
    });
    //pop the loading circle
    Navigator.pop(context);
    
    setState(() {
      _userFuture = _getCurrentUser();
    });

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Meal Removed from collection',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 2),
    ),
  );

  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayDialogMessage(e.code, context);
  }
}



  Widget _buildCustomExpansionTile({
    required String title,
    required List<Widget> children,
    bool? isExpanded
  }) {
    isExpanded ??= false;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

          return Scaffold(
            bottomNavigationBar: const BottomBar(),
            floatingActionButton: const MyFab(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    HomePageTitle(text: "${user.name}'s collection"),
                    _buildCustomExpansionTile(
                      isExpanded: true,
                      title: "Saved Meals",
                      children: [

                        Container(
                          constraints: const BoxConstraints(maxHeight: 800),
                          child: _buildMealRows(user.savedMeals),
                        ),
                      ],
                    ),
                    _buildCustomExpansionTile(
                      title: "Custom Meals",
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 800),
                          child: _buildMealRows(user.customMeals),
                        ),
                      ],
                    ),
                    _buildCustomExpansionTile(
                      title: "Saved Workouts",
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 800),
                          child: _buildWorkoutRows(user.savedWorkouts),
                        ),
                      ],
                    ),
                    _buildCustomExpansionTile(
                      title: "Custom Workouts",
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 800),
                          child: _buildWorkoutRows(user.customWorkouts),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
