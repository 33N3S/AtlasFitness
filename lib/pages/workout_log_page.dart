import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_workout_library.dart';
import 'package:atlas_fitness/components/workout_log_adder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutLogPage extends StatefulWidget {
  const WorkoutLogPage({ Key? key }) : super(key: key);

  @override
  _WorkoutLogPageState createState() => _WorkoutLogPageState();
}

class _WorkoutLogPageState extends State<WorkoutLogPage> {

  TextEditingController searchController = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyFab(),
      bottomNavigationBar: const BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const HomePageTitle(text: "Custom Log"),
              WorkoutLogAdder(),
              const SizedBox(height: 20),
              const HomePageTitle(text: "Workout Library"),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6, // Set a max height to prevent overflow
                ),
                child: MyWorkoutLibrary(searchController: searchController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}