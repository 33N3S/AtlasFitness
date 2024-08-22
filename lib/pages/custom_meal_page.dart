import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/custom_meal_adder.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMealPage extends StatefulWidget {
  const CustomMealPage({ Key? key }) : super(key: key);

  @override
  _CustomMealPageState createState() => _CustomMealPageState();
}

class _CustomMealPageState extends State<CustomMealPage> {

  TextEditingController nameController = TextEditingController();
  String selectedCategory = MealCategoriesEnum.values.first.name; 
  bool isWaiting = false;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: const MyFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).colorScheme.surface,
  
      body : SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const HomePageTitle(text: "Add Custom Meal"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 20),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceContainer
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.camera_fill,color: Theme.of(context).colorScheme.primary,size: 30,)),
                  Text("Take a tasty picture",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: MyTextField(controller: nameController, hintText: "Meal name", obscureText: false),
            ),

            CustomMealAdder(mealNameController: nameController),
          ],
        ),
      ))
    );
  }
}