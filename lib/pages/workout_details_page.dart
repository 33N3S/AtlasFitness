import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/components/my_enablable_button.dart';
import 'package:atlas_fitness/components/my_footer_illustrated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutDetails extends StatefulWidget {
  final Workout workout;

  const WorkoutDetails({Key? key, required this.workout}) : super(key: key);

  @override
  State<WorkoutDetails> createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {

  bool _isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('lib/images/workout_images/${widget.workout.imagePath}'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.workout.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        "Workout Tags",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50, // Set a fixed height for the ListView
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.workout.targetMuscles.length,
                          itemBuilder: (context, index) {
                            var muscle = widget.workout.targetMuscles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: FilterChip(
                                label: Text(
                                  muscle,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onSelected: (value) {},
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        "Workout Duration",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDuration(widget.workout.totalDuration),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        "Exercises",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: widget.workout.exercices.map((exercice) {
                            String exerciseName = exercice.name;
                            double duration = exercice.duration;
                            return Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exerciseName,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          exercice.description ,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.inversePrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                        ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    _formatDuration(duration),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.inversePrimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        "Total Calories Burned",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Text(
                        '${widget.workout.totalBurnedCalories.toStringAsFixed(1)} Cals',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                        
                      ),

                      const SizedBox(height: 25,),

                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: MyEnabledButton(text: "Mark as Done", onTap: () { workoutLog();}, enabled: true,waiting: _isWaiting)),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bookmark, size: 45,),),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                MyFooterIllustrated()
              ],
            ),
          ),
        ),
        SafeArea(
          child: Opacity(
            opacity: 0.7,
            child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    shape: BoxShape.circle),
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () => Navigator.pop(context))
            ),
          ),
        ),
      ],
    );
  }

  void workoutLog() async{

    setState(() {
      _isWaiting = true;
    });

    await _updateDailyIntake(widget.workout.totalBurnedCalories);

    setState(() {
      _isWaiting = false;
    });


  }

  Future<void> _updateDailyIntake(double calories) async {
    DateTime today = DateTime.now();

    Nutrients currentNutrients = Nutrients(
      calories: calories,
      protein: 0,
      carbs: 0,
      fats: 0,
    );

    // Save the updated daily intake
    await FirestoreService().updateDailyIntakeWorkout(today, currentNutrients);
  }

  String _formatDuration(double seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = (seconds % 60).toInt();

    if (minutes > 0) {
      if(remainingSeconds >0){
          return '$minutes min';
      }else{
          return '$minutes min';
      }
    } else {
      return '$remainingSeconds sec';
    }
  }
}
