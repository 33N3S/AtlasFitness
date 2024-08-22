import 'package:flutter/material.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_base.dart';
import 'package:atlas_fitness/components/my_meal_tile.dart';
import 'package:atlas_fitness/components/my_text_field.dart';

class MyMealLibrary extends StatefulWidget {
  final TextEditingController searchController;

  const MyMealLibrary({Key? key, required this.searchController}) : super(key: key);

  @override
  _MyMealLibraryState createState() => _MyMealLibraryState();
}

class _MyMealLibraryState extends State<MyMealLibrary> {
  final meals = MealBase.mealList;
  Map<String, List<Meal>> categorizedMeals = {};
  String _selectedCategory = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    categorizedMeals = _categorizeMeals(meals);
    _selectedCategory = categorizedMeals.keys.first;
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
            length: categorizedMeals.keys.length,
            child: Column(
              children: [
                TabBar(
                  tabs: categorizedMeals.keys.map((category) => Tab(text: category)).toList(),
                  labelColor: Theme.of(context).colorScheme.primary,
                  isScrollable: true,
                  onTap: (index) {
                    setState(() {
                      _selectedCategory = categorizedMeals.keys.elementAt(index);
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
                        itemCount: _getFilteredMeals().length,
                        itemBuilder: (context, index) {
                          return MyMealTile(meal: _getFilteredMeals()[index]);
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

  Map<String, List<Meal>> _categorizeMeals(List<Meal> meals) {
    Map<String, List<Meal>> categorizedMeals = {};

    for (var meal in meals) {
      String category = meal.category.name;
      if (!categorizedMeals.containsKey(category)) {
        categorizedMeals[category] = [];
      }
      categorizedMeals[category]!.add(meal);
    }

    return categorizedMeals;
  }

  List<Meal> _getFilteredMeals() {
    List<Meal> meals = categorizedMeals[_selectedCategory] ?? [];
    if (_searchQuery.isNotEmpty) {
      meals = meals
          .where((meal) => meal.name.toLowerCase().contains(_searchQuery))
          .toList();
    }
    return meals;
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = widget.searchController.text.toLowerCase();
    });
  }
}
