import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/backend/model/meal_base.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/meal_log_adder.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_meal_library.dart';
import 'package:flutter/material.dart';

class MealLogPage extends StatefulWidget {
  MealLogPage({Key? key}) : super(key: key);

  @override
  _MealLogPageState createState() => _MealLogPageState();
}

class _MealLogPageState extends State<MealLogPage> {
  final TextEditingController searchController = TextEditingController();
  final meals = MealBase.mealList;

  @override
  void dispose() {
    FoodBase.food_selector_list.clear();
    super.dispose();
  }

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
              MealLogAdder(),
              const SizedBox(height: 20),
              const HomePageTitle(text: "Meal Library"),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6, // Set a max height to prevent overflow
                ),
                child: MyMealLibrary(searchController: searchController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

