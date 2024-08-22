import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:atlas_fitness/pages/workout_details_page.dart';
import 'package:flutter/material.dart';

class myWorkoutTile extends StatelessWidget {

  final Workout workout;


  myWorkoutTile({ Key? key, 
  required this.workout }) : super(key: key);


  @override
  Widget build(BuildContext context){


    return GestureDetector(
      onTap: () => Navigator.push( context,MaterialPageRoute(builder: (context)=>WorkoutDetails(workout: workout))),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Image.asset('lib/images/workout_images/${workout.imagePath}',
          width: 180,),
          Padding(
            padding: const EdgeInsets.only(top:0),
            child: SizedBox(
              width: 220,
              child: Text(workout.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color:Theme.of(context).colorScheme.inversePrimary
              ),),
            ),
          ),
            Row(
              children: [
                FilterChip(
                  label: Text(workout.type.name, style: TextStyle(fontSize: 12),), onSelected: (value){},
                  )
              ],
            ),
        ],),
      ),
    );
  }
  
}