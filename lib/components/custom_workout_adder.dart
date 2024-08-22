import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/exercice.dart';
import 'package:atlas_fitness/backend/model/food.dart';
import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/backend/model/workout_base.dart';
import 'package:atlas_fitness/components/my_enablable_button.dart';
import 'package:atlas_fitness/components/my_exercice_selector.dart';
import 'package:atlas_fitness/components/my_food_selector.dart';
import 'package:atlas_fitness/components/my_quantity_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWorkoutAdder extends StatefulWidget {

  final TextEditingController mealNameController;


  const CustomWorkoutAdder({Key? key, required this.mealNameController, }) : super(key: key);

  @override
  State<CustomWorkoutAdder> createState() => _CustomWorkoutAdderState();
}

class _CustomWorkoutAdderState extends State<CustomWorkoutAdder> {
  
  Map<Exercice, TextEditingController> exerciceControllers = {};
  String selectedCategory = ExerciceType.values.first.name; 
  bool isButtonEnabled = false;
  bool isWaiting = false; // Added state variable for waiting
  late double totalValue;

  @override
  void initState() {
    super.initState();
    widget.mealNameController.addListener(checkButtonStatus);
    for (var controller in exerciceControllers.values) {
      controller.addListener(checkButtonStatus);
    }
  }

  @override
  void dispose() {
    widget.mealNameController.removeListener(checkButtonStatus);
    for (var controller in exerciceControllers.values) {
      controller.removeListener(checkButtonStatus);
      controller.dispose();
    }
    WorkoutBase.selectedCustomExercices.clear();
    super.dispose();
  }

  void checkButtonStatus() {
    // Check if the meal name is filled
    bool isNameFilled = widget.mealNameController.text.isNotEmpty;

    // Check if there are any food items selected
    if (exerciceControllers.isNotEmpty) {
      // Check if all the fields corresponding to the selected food items are filled
      bool allFieldsFilled = exerciceControllers.values.every((controller) => controller.text.isNotEmpty);
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
                      itemCount: ExerciceType.values.length,
                      itemBuilder: (context, index) {
                        var category = ExerciceType.values[index];
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
                      child: MyExerciceSelector(
                        exerices: WorkoutBase.allExercises,
                        searchController: TextEditingController(),
                        selectedExercices: WorkoutBase.selectedCustomExercices,
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
              const Text("Add Exercice"),
            ],
          ),
          Column(
            children: WorkoutBase.selectedCustomExercices.map((exerciceItem) {
              exerciceControllers.putIfAbsent(exerciceItem, () => TextEditingController());

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        WorkoutBase().removeexerciceItem(exerciceItem, WorkoutBase.selectedCustomExercices);
                        exerciceControllers.remove(exerciceItem);
                        checkButtonStatus();
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(exerciceItem.name),
                    const Spacer(),
                    MyQuantityTextField(
                      controller: exerciceControllers[exerciceItem]!,
                      hintText: "Duration",
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
              text: "Save Custom Workout",
              waiting: isWaiting, // Set waiting state
              onTap: () {
                saveCustomExercice();
              },
              enabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }

  void saveCustomExercice() async {
    setState(() {
      isWaiting = true; // Set waiting to true when the process starts
    });

    List<Exercice> selectedExercices = [];

    for (var exercice in WorkoutBase.selectedExercices) {
      exercice.duration = double.parse(exerciceControllers[exercice]!.text);
      selectedExercices.add(exercice);
    }

    Workout workout = Workout(
      type: ExerciceType.Balance, 
      name: '', 
      exercices: selectedExercices, 
      tag: FitGoals.gainMuscle, 
      imagePath: '');


    WorkoutBase.selectedCustomExercices.clear();
  
    setState(() {});

    // Call the service to update the daily intake
    await _insertCustomWorkout(workout);

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
                  "you'll find your workout in your collection page",
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

  Future<void> _insertCustomWorkout(Workout workout) async {
    // Save the updated daily intake
    await FirestoreService().insertCustomWorkout(workout);
  }
}

