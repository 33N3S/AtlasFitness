import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/pages/meal_details_page.dart';
import 'package:flutter/material.dart';

class MyMealTile extends StatelessWidget {

  final Meal meal;


  MyMealTile({ Key? key, 
  required this.meal }) : super(key: key);


  @override
  Widget build(BuildContext context){

    if(meal.imagePath.contains('jpg')){
        meal.imagePath = 'egg_avocado_toast.jfif';
      }

    return GestureDetector(
      onTap: () => Navigator.push( context,MaterialPageRoute(builder: (context)=>MealDetails(meal: meal))),
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
          Image.asset('lib/images/meals_images/'+meal.imagePath,
          width: 180,),
          Padding(
            padding: const EdgeInsets.only(top:0),
            child: SizedBox(
              width: 220,
              child: Text(meal.name,
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
                  label: Text(meal.category.name, style: TextStyle(fontSize: 12),), onSelected: (value){},
                  )
              ],
            ),
        ],),
      ),
    );
  }
  
}