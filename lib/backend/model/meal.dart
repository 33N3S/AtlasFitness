import 'package:atlas_fitness/backend/model/food.dart';
import 'package:atlas_fitness/backend/model/food_base.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';

class Meal {
  final String name;
  late Map<Food, double> ingredients; // Food objects with their respective quantities
  final FitGoals tag;
  late String imagePath;
  final String recipe;
  late Nutrients totalValue;
  late String imageUrl;
  final MealCategoriesEnum category;
  final Map<String, double> ingredientNames; // Ingredient names with their respective quantities

  Meal({
    required this.name,
    required this.tag,
    required this.imagePath,
    required this.recipe,
    required this.category,
    required this.ingredientNames,
  }) {
    ingredients = {}; 
    imageUrl = '';// Initialize ingredients as an empty map
    getFoodItems();
    calculateTotalValue();
  }

  void getFoodItems() {
    FoodBase foodBase = FoodBase();

    for (var entry in ingredientNames.entries) {
      var foundFood = foodBase.findFoodByName(entry.key);
      if (foundFood != null) {
        ingredients[foundFood] = entry.value; // Assign the food object with its quantity
      }
    }
  }


  void calculateTotalValue() {
    double proteins = 0;
    double carbs = 0;
    double fats = 0;
    for (var entry in ingredients.entries) {
      var food = entry.key;
      var quantity = entry.value;
      proteins += food.nutrients.protein * quantity /100;
      carbs += food.nutrients.carbs * quantity/ 100;
      fats += food.nutrients.fats * quantity/ 100;
    }
    double calories = proteins * 4 + carbs * 4 + fats * 9;
    totalValue = Nutrients(calories: calories, protein: proteins, carbs: carbs, fats: fats);
  }

  // Convert Meal to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredientNames': ingredientNames,
      'tag': tag.toString(),
      'imagePath': imagePath,
      'recipe': recipe,
      'totalValue': totalValue.toMap(),
      'category': category.name,
      'imageUrl': imageUrl
    };
  }

  // Convert Map to Meal
  factory Meal.fromMap(Map<String, dynamic> map) {
    Map<String, double> ingredientNames = Map<String, double>.from(map['ingredientNames'] ?? {});

    return Meal(
      name: map['name'],
      tag: FitGoals.values.firstWhere((e) => e.toString() == map['tag']),
      imagePath: map['imagePath'],
      recipe: map['recipe'],
      category: MealCategoriesEnumExtension.fromString(map['category']),
      ingredientNames: ingredientNames,
    )
    ..totalValue = Nutrients.fromMap(map['totalValue'])..imageUrl= map['imageUrl'];

  }


}
