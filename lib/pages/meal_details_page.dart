import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:atlas_fitness/components/my_enablable_button.dart';
import 'package:atlas_fitness/components/my_footer_illustrated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MealDetails extends StatefulWidget {
  final Meal meal;

  const MealDetails({Key? key, required this.meal}) : super(key: key);

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {

  bool _isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align everything to the start
            children: [
              Image.asset('lib/images/meals_images/' + widget.meal.imagePath),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.meal.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
          
      
      
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        FilterChip(
          
                          label: Text(
                            widget.meal.category.name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          onSelected: (value) {},
                        ),
                        const SizedBox(width: 15,),
                        FilterChip(
                          label: Text(
                            switch(widget.meal.tag.name){
                               'loseWeight' => 'Weight Loss',
                               'gainMuscle' => 'Muscle Gain',
                              String() => throw UnimplementedError(),
                            },
                            style: const TextStyle(fontSize: 12),
                          ),
                          onSelected: (value) {},
                        ),
                      ],
                    ),
          
            
                    const SizedBox(height: 15),
                    Text(
                      widget.meal.recipe,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
          
        
                    const SizedBox(height: 15,),
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right:20),
                      child: Column(
                        children: widget.meal.ingredientNames.entries.map((entry) {
                          String ingredientName = entry.key;
                          double quantity = entry.value;
                          return Row(
                            children: [
                              Text(ingredientName,
                              style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),),
                              const Spacer(),
                              Text(quantity.toStringAsFixed(1)+' g',
                              style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),)
                            ],
                          );
                        }).toList(),
                      ),
                    ),
          
                    const SizedBox(height: 15,),
                    Text(
                      "Total Nutritional Value",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 10),
          
                    Padding(
                      padding: const EdgeInsets.only(right:20),
                      child: Column(
                        children: widget.meal.totalValue.toMap().entries.map((nutrient){
                            return Row(
                              children: [
                                Text(nutrient.key,
                                style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),),
                                const Spacer(),
                                Text(nutrient.value.toStringAsFixed(1) + ' g',
                                style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),)
                              ],
                            ); 
                        }).toList()
                      ),
                    ),
      
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
      
              Row(
                children: [
                  Expanded(child: MyEnabledButton(text: "Mark as Eaten", onTap:(){ _quickMealLog(); }, enabled: true,waiting: _isWaiting),),
                  Padding(
                    padding: const EdgeInsets.only(right:15),
                    child: IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bookmark,size: 45,),),
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
          opacity: 0.85,
          child: Container(
            margin:EdgeInsets.all(15),
            decoration:BoxDecoration(
            color:Theme.of(context).colorScheme.surfaceContainer,
            shape: BoxShape.circle),
            child:IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context))
          ),
        ),
      ),
      
      ]
    );
  }

  void _quickMealLog() async{
  
    setState(() {
      _isWaiting = true;
    });

    await _updateDailyIntake(widget.meal.totalValue);

    setState(() {
      _isWaiting = false;
    });

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
}
