import 'package:atlas_fitness/backend/model/food.dart';
import 'package:atlas_fitness/backend/model/food_categories_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';
import 'package:flutter/cupertino.dart';

class FoodBase extends ChangeNotifier{

  static List<Food> food_selector_list = [];

  static List<Food> custom_food_list = [];

  static final List<Food> foodList =  [
  // Fruits
  Food(name: 'Apple', nutrients: Nutrients(calories: 52, protein: 0.3, carbs: 14, fats: 0.2), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Banana', nutrients: Nutrients(calories: 89, protein: 1.1, carbs: 23, fats: 0.3), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Orange', nutrients: Nutrients(calories: 47, protein: 0.9, carbs: 12, fats: 0.1), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Strawberry', nutrients: Nutrients(calories: 32, protein: 0.7, carbs: 7.7, fats: 0.3), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Blueberry', nutrients: Nutrients(calories: 57, protein: 0.7, carbs: 14.5, fats: 0.3), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Grapes', nutrients: Nutrients(calories: 69, protein: 0.7, carbs: 18, fats: 0.2), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Watermelon', nutrients: Nutrients(calories: 30, protein: 0.6, carbs: 7.6, fats: 0.2), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Pineapple', nutrients: Nutrients(calories: 50, protein: 0.5, carbs: 13, fats: 0.1), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Mango', nutrients: Nutrients(calories: 60, protein: 0.8, carbs: 15, fats: 0.4), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Kiwi', nutrients: Nutrients(calories: 61, protein: 1.1, carbs: 15, fats: 0.5), category: FoodCategoriesEnum.Fruits),
  Food(name: 'Mixed Berries',nutrients: Nutrients(calories: 57, protein: 0.7, carbs: 14, fats: 0.3),category: FoodCategoriesEnum.Fruits),

  // Vegetables
  Food(name: 'Carrot', nutrients: Nutrients(calories: 41, protein: 0.9, carbs: 10, fats: 0.2), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Broccoli', nutrients: Nutrients(calories: 55, protein: 3.7, carbs: 11.1, fats: 0.6), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Spinach', nutrients: Nutrients(calories: 23, protein: 2.9, carbs: 3.6, fats: 0.4), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Tomato', nutrients: Nutrients(calories: 18, protein: 0.9, carbs: 3.9, fats: 0.2), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Cucumber', nutrients: Nutrients(calories: 16, protein: 0.7, carbs: 3.6, fats: 0.1), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Pepper', nutrients: Nutrients(calories: 31, protein: 1, carbs: 6, fats: 0.3), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Onion', nutrients: Nutrients(calories: 40, protein: 1.1, carbs: 9.3, fats: 0.1), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Lettuce', nutrients: Nutrients(calories: 15, protein: 1.4, carbs: 2.9, fats: 0.2), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Garlic', nutrients: Nutrients(calories: 149, protein: 6.4, carbs: 33.1, fats: 0.5), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Zucchini', nutrients: Nutrients(calories: 17, protein: 1.2, carbs: 3.1, fats: 0.3), category: FoodCategoriesEnum.Vegetables),
  Food(name: 'Green Beans',nutrients: Nutrients(calories: 31, protein: 1.8, carbs: 7, fats: 0.1),category: FoodCategoriesEnum.Vegetables),

  // Grains
  Food(name: 'Rice', nutrients: Nutrients(calories: 130, protein: 2.4, carbs: 28, fats: 0.3), category: FoodCategoriesEnum.Grains),
  Food(name: 'Oats', nutrients: Nutrients(calories: 389, protein: 16.9, carbs: 66.3, fats: 6.9), category: FoodCategoriesEnum.Grains),
  Food(name: 'Quinoa', nutrients: Nutrients(calories: 120, protein: 4.1, carbs: 21.3, fats: 1.9), category: FoodCategoriesEnum.Grains),
  Food(name: 'Barley', nutrients: Nutrients(calories: 354, protein: 12.5, carbs: 73.5, fats: 2.3), category: FoodCategoriesEnum.Grains),
  Food(name: 'Corn', nutrients: Nutrients(calories: 86, protein: 3.2, carbs: 19, fats: 1.2), category: FoodCategoriesEnum.Grains),
  Food(name: 'Millet', nutrients: Nutrients(calories: 119, protein: 3.5, carbs: 23.7, fats: 1), category: FoodCategoriesEnum.Grains),
  Food(name: 'Buckwheat', nutrients: Nutrients(calories: 343, protein: 13.3, carbs: 71.5, fats: 3.4), category: FoodCategoriesEnum.Grains),
  Food(name: 'Couscous', nutrients: Nutrients(calories: 112, protein: 3.8, carbs: 23.2, fats: 0.2), category: FoodCategoriesEnum.Grains),
  Food(name: 'Bulgur', nutrients: Nutrients(calories: 342, protein: 12.3, carbs: 76, fats: 1.3), category: FoodCategoriesEnum.Grains),
  Food(name: 'Amaranth', nutrients: Nutrients(calories: 371, protein: 13.6, carbs: 65, fats: 7), category: FoodCategoriesEnum.Grains),
  Food(name: 'Whole Grain Bread',nutrients: Nutrients(calories: 247, protein: 8.9, carbs: 41, fats: 4.2),category: FoodCategoriesEnum.Grains),
  Food(name: 'Granola',nutrients: Nutrients(calories: 471, protein: 10, carbs: 64, fats: 20),category: FoodCategoriesEnum.Grains),

  // Proteins
  Food(name: 'Chicken Breast', nutrients: Nutrients(calories: 165, protein: 31, carbs: 0, fats: 3.6), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Turkey Breast', nutrients: Nutrients(calories: 135, protein: 30, carbs: 0, fats: 1), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Beef', nutrients: Nutrients(calories: 250, protein: 26, carbs: 0, fats: 15), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Pork', nutrients: Nutrients(calories: 242, protein: 27, carbs: 0, fats: 14), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Eggs', nutrients: Nutrients(calories: 155, protein: 13, carbs: 1.1, fats: 11), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Tofu', nutrients: Nutrients(calories: 76, protein: 8, carbs: 1.9, fats: 4.8), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Tempeh', nutrients: Nutrients(calories: 192, protein: 20.3, carbs: 7.6, fats: 10.8), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Greek Yogurt', nutrients: Nutrients(calories: 59, protein: 10, carbs: 3.6, fats: 0.4), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Cottage Cheese', nutrients: Nutrients(calories: 98, protein: 11.1, carbs: 3.4, fats: 4.3), category: FoodCategoriesEnum.Proteins),
  Food(name: 'Lentils', nutrients: Nutrients(calories: 116, protein: 9, carbs: 20, fats: 0.4), category: FoodCategoriesEnum.Proteins),

  // Dairy
  Food(name: 'Milk', nutrients: Nutrients(calories: 42, protein: 3.4, carbs: 5, fats: 1), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Cheese', nutrients: Nutrients(calories: 402, protein: 25, carbs: 1.3, fats: 33), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Butter', nutrients: Nutrients(calories: 717, protein: 0.9, carbs: 0.1, fats: 81), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Yogurt', nutrients: Nutrients(calories: 59, protein: 10, carbs: 3.6, fats: 0.4), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Cream', nutrients: Nutrients(calories: 206, protein: 2, carbs: 3, fats: 21), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Ice Cream', nutrients: Nutrients(calories: 207, protein: 3.5, carbs: 23.6, fats: 11), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Kefir', nutrients: Nutrients(calories: 41, protein: 3.3, carbs: 4.8, fats: 0.8), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Buttermilk', nutrients: Nutrients(calories: 40, protein: 3.3, carbs: 4.8, fats: 0.9), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Ghee', nutrients: Nutrients(calories: 900, protein: 0, carbs: 0, fats: 100), category: FoodCategoriesEnum.Dairy),
  Food(name: 'Paneer', nutrients: Nutrients(calories: 265, protein: 18.9, carbs: 6.1, fats: 20.8), category: FoodCategoriesEnum.Dairy),

  // Nuts & Seeds
  Food(name: 'Almonds', nutrients: Nutrients(calories: 579, protein: 21.2, carbs: 21.6, fats: 49.9), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Walnuts', nutrients: Nutrients(calories: 654, protein: 15.2, carbs: 13.7, fats: 65.2), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Cashews', nutrients: Nutrients(calories: 553, protein: 18.2, carbs: 30.2, fats: 43.9), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Peanuts', nutrients: Nutrients(calories: 567, protein: 25.8, carbs: 16.1, fats: 49.2), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Chia Seeds', nutrients: Nutrients(calories: 486, protein: 16.5, carbs: 42.1, fats: 30.7), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Flax Seeds', nutrients: Nutrients(calories: 534, protein: 18.3, carbs: 28.9, fats: 42.2), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Sunflower Seeds', nutrients: Nutrients(calories: 584, protein: 20.8, carbs: 20, fats: 51), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Pumpkin Seeds', nutrients: Nutrients(calories: 446, protein: 19, carbs: 53.7, fats: 19.4), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Sesame Seeds', nutrients: Nutrients(calories: 573, protein: 17.7, carbs: 23.5, fats: 49.7), category: FoodCategoriesEnum.NutsAndSeeds),
  Food(name: 'Pistachios', nutrients: Nutrients(calories: 562, protein: 20.2, carbs: 27.2, fats: 45.8), category: FoodCategoriesEnum.NutsAndSeeds),

  // Seafood
  Food(name: 'Salmon', nutrients: Nutrients(calories: 208, protein: 20, carbs: 0, fats: 13), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Tuna', nutrients: Nutrients(calories: 144, protein: 30, carbs: 0, fats: 4.9), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Shrimp', nutrients: Nutrients(calories: 99, protein: 24, carbs: 0.2, fats: 0.3), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Crab', nutrients: Nutrients(calories: 83, protein: 18, carbs: 0, fats: 0.6), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Lobster', nutrients: Nutrients(calories: 77, protein: 16, carbs: 1.2, fats: 0.7), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Mackerel', nutrients: Nutrients(calories: 305, protein: 19, carbs: 0, fats: 25), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Sardines', nutrients: Nutrients(calories: 208, protein: 24, carbs: 0, fats: 11), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Cod', nutrients: Nutrients(calories: 82, protein: 18, carbs: 0, fats: 0.7), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Tilapia', nutrients: Nutrients(calories: 96, protein: 21, carbs: 0, fats: 1.7), category: FoodCategoriesEnum.Seafood),
  Food(name: 'Oysters', nutrients: Nutrients(calories: 68, protein: 7, carbs: 4, fats: 2), category: FoodCategoriesEnum.Seafood),

  // Legumes
  Food(name: 'Beans', nutrients: Nutrients(calories: 347, protein: 21, carbs: 63, fats: 1.2), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Chickpeas', nutrients: Nutrients(calories: 364, protein: 19, carbs: 61, fats: 6), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Peas', nutrients: Nutrients(calories: 81, protein: 5, carbs: 14, fats: 0.4), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Lentils', nutrients: Nutrients(calories: 116, protein: 9, carbs: 20, fats: 0.4), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Soybeans', nutrients: Nutrients(calories: 446, protein: 36.5, carbs: 30.2, fats: 20.2), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Black Beans', nutrients: Nutrients(calories: 132, protein: 8.9, carbs: 23.7, fats: 0.5), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Kidney Beans', nutrients: Nutrients(calories: 127, protein: 8.7, carbs: 22.8, fats: 0.5), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Pinto Beans', nutrients: Nutrients(calories: 143, protein: 9, carbs: 26.2, fats: 0.6), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Navy Beans', nutrients: Nutrients(calories: 140, protein: 8.2, carbs: 26.7, fats: 0.6), category: FoodCategoriesEnum.Legumes),
  Food(name: 'Lima Beans', nutrients: Nutrients(calories: 113, protein: 7.8, carbs: 20.2, fats: 0.5), category: FoodCategoriesEnum.Legumes),
  
  // Miscellaneous
  Food(name: 'Dark Chocolate', nutrients: Nutrients(calories: 546, protein: 4.9, carbs: 61, fats: 31), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Honey', nutrients: Nutrients(calories: 304, protein: 0.3, carbs: 82.4, fats: 0), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Maple Syrup', nutrients: Nutrients(calories: 260, protein: 0, carbs: 67, fats: 0), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Soy Sauce', nutrients: Nutrients(calories: 53, protein: 8, carbs: 4.9, fats: 0.6), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Mustard', nutrients: Nutrients(calories: 66, protein: 4, carbs: 5, fats: 4), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Ketchup', nutrients: Nutrients(calories: 112, protein: 1.3, carbs: 26, fats: 0.2), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Vinegar', nutrients: Nutrients(calories: 18, protein: 0, carbs: 0.9, fats: 0), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Peanut Butter', nutrients: Nutrients(calories: 588, protein: 25, carbs: 20, fats: 50), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Jam', nutrients: Nutrients(calories: 250, protein: 0.3, carbs: 65, fats: 0.1), category: FoodCategoriesEnum.Miscellaneous),
  Food(name: 'Mayonnaise', nutrients: Nutrients(calories: 680, protein: 1, carbs: 1, fats: 75), category: FoodCategoriesEnum.Miscellaneous),
  

];

  final Map<String, Food> _foodMap = {};

  FoodBase() {
    for (var food in foodList) {
      _foodMap[food.name] = food;
    }
  }

  Food? findFoodByName(String name) {
    return _foodMap[name];
  }

  List<Food> filterFoodList({FoodCategoriesEnum? category, String? searchQuery}) {
    // Filtering by category if provided
    List<Food> filteredList = foodList.where((food) {
      final matchesCategory = category == null || food.category == category;
      final matchesSearchQuery = searchQuery == null || searchQuery.isEmpty || 
                                 food.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearchQuery;
    }).toList();

    return filteredList;
  }

  void addFoodItem(Food food,List<Food> list) {
    list.add(food);
    notifyListeners(); 
  }

  void removeFoodItem(Food food,List<Food> list) {
    list.remove(food);
    notifyListeners(); 
  }


}