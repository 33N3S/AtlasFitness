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

class CustomMealAdder extends StatefulWidget {

  final TextEditingController mealNameController;


  const CustomMealAdder({Key? key, required this.mealNameController, }) : super(key: key);

  @override
  State<CustomMealAdder> createState() => _CustomMealAdderState();
}

class _CustomMealAdderState extends State<CustomMealAdder> {
  
  Map<Food, TextEditingController> foodControllers = {};
  String selectedCategory = MealCategoriesEnum.values.first.name; 
  bool isButtonEnabled = false;
  bool isWaiting = false; // Added state variable for waiting
  late Nutrients totalValue;

  @override
  void initState() {
    super.initState();
    widget.mealNameController.addListener(checkButtonStatus);
    for (var controller in foodControllers.values) {
      controller.addListener(checkButtonStatus);
    }
  }

  @override
  void dispose() {
    widget.mealNameController.removeListener(checkButtonStatus);
    for (var controller in foodControllers.values) {
      controller.removeListener(checkButtonStatus);
      controller.dispose();
    }
    FoodBase.custom_food_list.clear();
    super.dispose();
  }

  void checkButtonStatus() {
    // Check if the meal name is filled
    bool isNameFilled = widget.mealNameController.text.isNotEmpty;

    // Check if there are any food items selected
    if (foodControllers.isNotEmpty) {
      // Check if all the fields corresponding to the selected food items are filled
      bool allFieldsFilled = foodControllers.values.every((controller) => controller.text.isNotEmpty);
      setState(() {
        isButtonEnabled = allFieldsFilled && isNameFilled;
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

            Center(
              child: SizedBox(
                height: 50, // Set a fixed height for the ListView
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the ListView
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: MealCategoriesEnum.values.length,
                      itemBuilder: (context, index) {
                        var category = MealCategoriesEnum.values[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilterChip(
                            selectedColor: Theme.of(context).colorScheme.secondary,
                            selected: selectedCategory == category.name,
                            side: const BorderSide(
                              color: Colors.transparent
                            ),
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                            label: Text(
                              category.name,
                              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary),
                            ),
                            onSelected: (isSelected) {
                              setState(() {
                                  selectedCategory = category.name; 
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

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
                        selectedFoodItems: FoodBase.custom_food_list,
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
            children: FoodBase.custom_food_list.map((foodItem) {
              foodControllers.putIfAbsent(foodItem, () => TextEditingController());

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        FoodBase().removeFoodItem(foodItem, FoodBase.custom_food_list);
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
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: MyEnabledButton(
              text: "Save Custom Meal",
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

    for (var food in FoodBase.custom_food_list) {
      selectedNames.addAll({
        food.name: double.parse(foodControllers[food]!.value.text),
      });
    }

    Meal customMeal = Meal(
      name: widget.mealNameController.text,
      tag: FitGoals.loseWeight,
      imagePath: '',
      recipe: '',
      category: MealCategoriesEnumExtension.fromString(selectedCategory),
      ingredientNames: selectedNames,
    );


    FoodBase.custom_food_list.clear();
  
    setState(() {});

    // Call the service to update the daily intake
    await _insertCustomMeal(customMeal);

    setState(() {
      isWaiting = false; // Set waiting to false when the process finishes
    });

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Looking Good !",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "you'll find your meal in your collection page",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _insertCustomMeal(Meal meal) async {
    // Save the updated daily intake
    await FirestoreService().insertCustomMeal(meal);
  }
}

