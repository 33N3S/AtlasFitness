import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/components/my_register_button.dart';
import 'package:atlas_fitness/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:atlas_fitness/backend/model/food.dart';

class MyFoodSelector extends StatefulWidget {
  final TextEditingController searchController;
  final List<Food> foodItems;
  final List<Food> selectedFoodItems;

  MyFoodSelector({
    Key? key,
    required this.searchController,
    required this.foodItems,
    required this.selectedFoodItems,
  }) : super(key: key);

  @override
  _MyFoodSelectorState createState() => _MyFoodSelectorState();
}

class _MyFoodSelectorState extends State<MyFoodSelector> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  late Map<String, List<Food>> categorizedFoodItems;

  @override
  void initState() {
    super.initState();
    categorizedFoodItems = _categorizeFoodItems(widget.foodItems);
    widget.searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = widget.searchController.text.toLowerCase();
    });
  }

  Map<String, List<Food>> _categorizeFoodItems(List<Food> foodItems) {
    Map<String, List<Food>> categorizedItems = {};

    for (var food in foodItems) {
      String category = food.category.name;
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(food);
    }

    return categorizedItems;
  }

  List<Food> _getFilteredFoodItems() {
    List<Food> foodItems;

    if (_selectedCategory == 'All') {
      foodItems = widget.foodItems;
    } else {
      foodItems = categorizedFoodItems[_selectedCategory] ?? [];
    }

    if (_searchQuery.isNotEmpty) {
      foodItems = foodItems.where((food) => food.name.toLowerCase().contains(_searchQuery)).toList();
    }

    return foodItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MyTextField(
            controller: widget.searchController,
            hintText: "Search in category",
            obscureText: false,
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: DefaultTabController(
              length: categorizedFoodItems.keys.length + 1, // Add +1 for the "All" tab
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    onTap: (index) {
                      setState(() {
                        if (index == 0) {
                          _selectedCategory = 'All';
                        } else {
                          _selectedCategory = categorizedFoodItems.keys.elementAt(index - 1);
                        }
                      });
                    },
                    tabs: [
                      Tab(text: 'All'), // Add "All" tab
                      ...categorizedFoodItems.keys.map((category) => Tab(text: category)).toList(),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView( // For "All" tab
                          children: widget.foodItems
                              .where((food) => food.name.toLowerCase().contains(_searchQuery))
                              .map((foodItem) => ExpansionTile(
                                    title: Text(foodItem.name),
                                    children: [
                                      _buildMacronutrientRow("Proteins", foodItem.nutrients.protein),
                                      _buildMacronutrientRow("Carbs", foodItem.nutrients.carbs),
                                      _buildMacronutrientRow("Fats", foodItem.nutrients.fats),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 80, right: 15, top: 10, bottom: 10),
                                        child: MyRegisterButton(
                                          text: "Add",
                                          onTap: () {
                                            FoodBase().addFoodItem(foodItem, widget.selectedFoodItems);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                        ...categorizedFoodItems.keys.map((category) {
                          return ListView(
                            children: _getFilteredFoodItems()
                                .map((foodItem) => ExpansionTile(
                                      title: Text(foodItem.name),
                                      children: [
                                        _buildMacronutrientRow("Proteins", foodItem.nutrients.protein),
                                        _buildMacronutrientRow("Carbs", foodItem.nutrients.carbs),
                                        _buildMacronutrientRow("Fats", foodItem.nutrients.fats),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 80, right: 15, top: 10, bottom: 10),
                                          child: MyRegisterButton(
                                            text: "Add",
                                            onTap: () {
                                              FoodBase().addFoodItem(foodItem, widget.selectedFoodItems);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ))
                                .toList(),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacronutrientRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
