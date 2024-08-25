import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/food.dart';
import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/components/my_enablable_button.dart';
import 'package:atlas_fitness/components/my_food_selector.dart';
import 'package:atlas_fitness/components/my_quantity_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealLogAdder extends StatefulWidget {
  MealLogAdder({Key? key}) : super(key: key);

  @override
  State<MealLogAdder> createState() => _MealLogAdderState();
}

class _MealLogAdderState extends State<MealLogAdder> {
  Map<Food, TextEditingController> foodControllers = {};
  bool isButtonEnabled = false;
  bool isWaiting = false; // Added state variable for waiting
  late Nutrients totalValue;

  @override
  void initState() {
    super.initState();
    for (var controller in foodControllers.values) {
      controller.addListener(checkButtonStatus);
    }
  }

  @override
  void dispose() {
    for (var controller in foodControllers.values) {
      controller.removeListener(checkButtonStatus);
      controller.dispose();
    }
    FoodBase.food_selector_list.clear();
    super.dispose();
  }

  void checkButtonStatus() {
    // Check if there are any food items selected
    if (foodControllers.isNotEmpty) {
      // Check if all the fields corresponding to the selected food items are filled
      bool allFieldsFilled = foodControllers.values.every((controller) => controller.text.isNotEmpty);
      setState(() {
        isButtonEnabled = allFieldsFilled;
      });
    } else {
      // No food items selected, disable the button
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: MyFoodSelector(
                        foodItems: FoodBase.foodList,
                        searchController: TextEditingController(),
                        selectedFoodItems: FoodBase.food_selector_list,
                      ),
                    ),
                  ).then((_) => setState(() {
                    isButtonEnabled = false;
                  }));
                },
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Text("Add Element"),
            ],
          ),
          Column(
            children: FoodBase.food_selector_list.map((foodItem) {
              foodControllers.putIfAbsent(foodItem, () => TextEditingController());

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        FoodBase().removeFoodItem(foodItem,FoodBase.food_selector_list);
                        foodControllers.remove(foodItem);
                        checkButtonStatus();
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(foodItem.name),
                    const Spacer(),
                    MyQuantityTextField(
                      controller: foodControllers[foodItem]!,
                      hintText: "Quantity",
                      obscureText: false,
                      enabled: true,
                      onChanged: (value) => checkButtonStatus(),
                      unit: "grams",
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: MyEnabledButton(
              text: "Mark as Eaten",
              waiting: isWaiting, // Set waiting state
              onTap: () {
                quickMealLog();
              },
              enabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }

  void quickMealLog() async {
    setState(() {
      isWaiting = true; // Set waiting to true when the process starts
    });

    Map<String, double> selectedNames = {};

    for (var food in FoodBase.food_selector_list) {
      selectedNames.addAll({
        food.name: double.parse(foodControllers[food]!.value.text),
      });
    }

    Meal quickMeal = Meal(
      name: '',
      tag: FitGoals.loseWeight,
      imagePath: '',
      recipe: '',
      category: MealCategoriesEnum.Snack,
      ingredientNames: selectedNames,
    );

    totalValue = quickMeal.totalValue;

    FoodBase.food_selector_list.clear();
  
    setState(() {});

    // Call the service to update the daily intake
    await _updateDailyIntake(totalValue);

    setState(() {
      isWaiting = false; // Set waiting to false when the process finishes
    });

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Bon Appétit !",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your meal's nutritional value:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                _buildNutrientRow("Calories", "${totalValue.calories.toStringAsFixed(1)} Cals"),
                _buildNutrientRow("Proteins", "${totalValue.protein.toStringAsFixed(1)} g"),
                _buildNutrientRow("Carbs", "${totalValue.carbs.toStringAsFixed(1)} g"),
                _buildNutrientRow("Fats", "${totalValue.fats.toStringAsFixed(1)} g"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateDailyIntake(Nutrients nutrients) async {
    DateTime today = DateTime.now();

    Nutrients currentNutrients = Nutrients(
      calories: nutrients.calories,
      protein: nutrients.protein,
      carbs: nutrients.carbs,
      fats: nutrients.fats,
    );

    // Save the updated daily intake
    await FirestoreService().updateDailyIntakeNutrients(today, currentNutrients);
  }

  Widget _buildNutrientRow(String tag, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tag, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

