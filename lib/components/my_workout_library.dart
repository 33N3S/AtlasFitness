import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/backend/model/workout_base.dart';
import 'package:atlas_fitness/components/my_workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:atlas_fitness/components/my_text_field.dart';

class MyWorkoutLibrary extends StatefulWidget {
  final TextEditingController searchController;

  const MyWorkoutLibrary({Key? key, required this.searchController}) : super(key: key);

  @override
  _MyWorkoutLibraryState createState() => _MyWorkoutLibraryState();
}

class _MyWorkoutLibraryState extends State<MyWorkoutLibrary> {
  final workouts = WorkoutBase.workouts;
  Map<String, List<Workout>> categorizedWorkouts = {};
  String _selectedCategory = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    categorizedWorkouts = _categorizeMeals(workouts);
    _selectedCategory = categorizedWorkouts.keys.first;
    widget.searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: widget.searchController,
          hintText: "Search in category",
          obscureText: false,
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: DefaultTabController(
            length: categorizedWorkouts.keys.length,
            child: Column(
              children: [
                TabBar(
                  tabs: categorizedWorkouts.keys.map((category) => Tab(text: category)).toList(),
                  labelColor: Theme.of(context).colorScheme.primary,
                  isScrollable: true,
                  onTap: (index) {
                    setState(() {
                      _selectedCategory = categorizedWorkouts.keys.elementAt(index);
                    });
                  },
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.5,
                        ),
                        itemCount: _getFilteredWorkouts().length,
                        itemBuilder: (context, index) {
                          return myWorkoutTile(workout: _getFilteredWorkouts()[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Map<String, List<Workout>> _categorizeMeals(List<Workout> workouts) {
    Map<String, List<Workout>> categorizedMeals = {};

    for (var workout in workouts) {
      String category = workout.type.name;
      if (!categorizedMeals.containsKey(category)) {
        categorizedMeals[category] = [];
      }
      categorizedMeals[category]!.add(workout);
    }

    return categorizedMeals;
  }

  List<Workout> _getFilteredWorkouts() {
    List<Workout> workouts = categorizedWorkouts[_selectedCategory] ?? [];
    if (_searchQuery.isNotEmpty) {
      workouts = workouts
          .where((workout) => workout.name.toLowerCase().contains(_searchQuery))
          .toList();
    }
    return workouts;
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = widget.searchController.text.toLowerCase();
    });
  }
}
