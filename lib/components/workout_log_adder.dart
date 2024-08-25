import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/exercice.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/backend/model/workout_base.dart';
import 'package:atlas_fitness/components/my_enablable_button.dart';
import 'package:atlas_fitness/components/my_exercice_selector.dart';
import 'package:atlas_fitness/components/my_quantity_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutLogAdder extends StatefulWidget {
  WorkoutLogAdder({Key? key}) : super(key: key);

  @override
  State<WorkoutLogAdder> createState() => _WorkoutLogAdderState();
}

class _WorkoutLogAdderState extends State<WorkoutLogAdder> {
  Map<Exercice, TextEditingController> exerciceControllers = {};
  bool isButtonEnabled = false;
  bool isWaiting = false; // Added state variable for waiting
  late double totalValue;
  late Workout workout;

  @override
  void initState() {
    super.initState();
    for (var controller in exerciceControllers.values) {
      controller.addListener(checkButtonStatus);
    }
  }

  @override
  void dispose() {
    for (var controller in exerciceControllers.values) {
      controller.removeListener(checkButtonStatus);
      controller.dispose();
    }
    WorkoutBase.selectedExercices.clear();
    super.dispose();
  }

  void checkButtonStatus() {
    // Check if there are any food items selected
    if (exerciceControllers.isNotEmpty) {
      // Check if all the fields corresponding to the selected food items are filled
      bool allFieldsFilled = exerciceControllers.values.every((controller) => controller.text.isNotEmpty);
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
                      child: MyExerciceSelector(
                        exerices: WorkoutBase.allExercises,
                        searchController: TextEditingController(),
                        selectedExercices: WorkoutBase.selectedExercices,
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
            children: WorkoutBase.selectedExercices.map((exerciceItem) {
              exerciceControllers.putIfAbsent(exerciceItem, () => TextEditingController());

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        WorkoutBase().removeexerciceItem(exerciceItem,WorkoutBase.selectedExercices);
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
                      unit: "seconds",
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: MyEnabledButton(
              text: "Mark as Done",
              waiting: isWaiting, // Set waiting state
              onTap: () {
                quickExerciceLog();
              },
              enabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }

  void quickExerciceLog() async {
    setState(() {
      isWaiting = true; // Set waiting to true when the process starts
    });

    List<Exercice> selectedExercices = [];

    for (var exercice in WorkoutBase.selectedExercices) {
      exercice.duration = double.parse(exerciceControllers[exercice]!.text);
      selectedExercices.add(exercice);
    }

    workout = Workout(
      type: ExerciceType.Balance, 
      name: '', 
      exercices: selectedExercices, 
      tag: FitGoals.gainMuscle, 
      imagePath: '');

    totalValue = workout.totalBurnedCalories;

    WorkoutBase.selectedExercices.clear();
  
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
          alignment: Alignment.center,
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Way to go!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Take a well deserved rest",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                _buildNutrientRow("Burned calories", "${workout.totalBurnedCalories.toStringAsFixed(1)} Cals"),
                _buildNutrientRow("Duration", _formatDuration(workout.totalDuration)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateDailyIntake(double totalBurnedCalories) async {
    DateTime today = DateTime.now();

    Nutrients currentNutrients = Nutrients(
      calories: totalBurnedCalories,
      protein: 0,
      carbs: 0,
      fats: 0,
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

  String _formatDuration(double seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = (seconds % 60).toInt();

    if (minutes > 0) {
      if(remainingSeconds >0){
          return '$minutes min $remainingSeconds sec';
      }else{
          return '$minutes min';
      }
    } else {
      return '$remainingSeconds sec';
    }
  }
}

