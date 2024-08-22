import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/meal.dart';
import 'package:atlas_fitness/backend/model/meal_categories_enum.dart';

class MealBase{
  
  static final List<Meal> mealList = [
    Meal(
  name: 'Grilled Chicken Salad',
  tag: FitGoals.loseWeight,
  imagePath: 'grilled_chicken_salad.jfif',
  recipe: 'Grill the chicken breast. Toss it with spinach, tomatoes, cucumbers, and lettuce. Dress with lemon juice.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Chicken Breast': 200.0, // grams
    'Spinach': 50.0, // grams
    'Tomato': 100.0, // grams
    'Cucumber': 100.0, // grams
    'Lettuce': 50.0, // grams
  },
),
Meal(
  name: 'Oats with Berries',
  tag: FitGoals.loseWeight,
  imagePath: 'oats_with_berries.jfif',
  recipe: 'Cook oats with water or milk. Top with strawberries, blueberries, and almonds.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Oats': 50.0, // grams
    'Strawberry': 50.0, // grams
    'Blueberry': 50.0, // grams
    'Almonds': 20.0, // grams
  },
),
Meal(
  name: 'Quinoa and Veggie Stir-fry',
  tag: FitGoals.loseWeight,
  imagePath: 'quinoa_veggie_stirfry.jfif',
  recipe: 'Cook quinoa and stir-fry with broccoli, carrots, and bell peppers.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Quinoa': 100.0, // grams
    'Broccoli': 100.0, // grams
    'Carrot': 100.0, // grams
    'Pepper': 100.0, // grams
  },
),
Meal(
  name: 'Greek Yogurt with Nuts',
  tag: FitGoals.loseWeight,
  imagePath: 'greek_yogurt_nuts.jfif',
  recipe: 'Mix Greek yogurt with a handful of walnuts and chia seeds.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Greek Yogurt': 150.0, // grams
    'Walnuts': 30.0, // grams
    'Chia Seeds': 10.0, // grams
  },
),
Meal(
  name: 'Veggie Omelette',
  tag: FitGoals.loseWeight,
  imagePath: 'veggie_omelette.jfif',
  recipe: 'Beat eggs and cook with spinach, tomatoes, and onions.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Eggs': 100.0, // grams
    'Spinach': 50.0, // grams
    'Tomato': 100.0, // grams
    'Onion': 50.0, // grams
  },
),
Meal(
  name: 'Cottage Cheese and Pineapple',
  tag: FitGoals.loseWeight,
  imagePath: 'cottage_cheese_pineapple.jfif',
  recipe: 'Mix cottage cheese with fresh pineapple chunks.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Cottage Cheese': 150.0, // grams
    'Pineapple': 100.0, // grams
  },
),
Meal(
  name: 'Lentil Soup',
  tag: FitGoals.loseWeight,
  imagePath: 'lentil_soup.jfif',
  recipe: 'Cook lentils with carrots, onions, and garlic in a vegetable broth.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Lentils': 100.0, // grams
    'Carrot': 100.0, // grams
    'Onion': 50.0, // grams
    'Garlic': 10.0, // grams
  },
),
Meal(
  name: 'Spinach and Strawberry Salad',
  tag: FitGoals.loseWeight,
  imagePath: 'spinach_strawberry_salad.jfif',
  recipe: 'Mix spinach with sliced strawberries and a drizzle of balsamic vinegar.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Spinach': 50.0, // grams
    'Strawberry': 50.0, // grams
  },
),
Meal(
  name: 'Baked Zucchini with Parmesan',
  tag: FitGoals.loseWeight,
  imagePath: 'baked_zucchini.jfif',
  recipe: 'Slice zucchini and bake with a sprinkle of Parmesan cheese.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Zucchini': 200.0, // grams
    'Cheese': 30.0, // grams
  },
),
  Meal(
  name: 'Garlic Butter Shrimp',
  tag: FitGoals.loseWeight,
  imagePath: 'garlic_butter_shrimp.jfif',
  recipe: 'Sauté shrimp in garlic butter and serve with a side of steamed vegetables.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Shrimp': 150.0, // grams
    'Garlic': 10.0, // grams
    'Butter': 20.0, // grams
    'Broccoli': 100.0, // grams
  },
),
Meal(
  name: 'Fruit and Nut Snack',
  tag: FitGoals.loseWeight,
  imagePath: 'fruit_nut_snack.jfif',
  recipe: 'Mix a handful of almonds with apple slices and blueberries.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Almonds': 30.0, // grams
    'Apple': 150.0, // grams
    'Blueberry': 50.0, // grams
  },
),
Meal(
  name: 'Cucumber and Hummus',
  tag: FitGoals.loseWeight,
  imagePath: 'cucumber_hummus.jfif',
  recipe: 'Dip cucumber slices in hummus for a refreshing snack.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Cucumber': 100.0, // grams
    'Chickpeas': 100.0, // grams
  },
),
Meal(
  name: 'Broccoli and Tofu Stir-fry',
  tag: FitGoals.loseWeight,
  imagePath: 'broccoli_tofu_stirfry.jfif',
  recipe: 'Stir-fry tofu with broccoli and garlic, seasoned with soy sauce.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Tofu': 150.0, // grams
    'Broccoli': 100.0, // grams
    'Garlic': 10.0, // grams
  },
),
Meal(
  name: 'Grilled Chicken with Quinoa',
  tag: FitGoals.loseWeight,
  imagePath: 'grilled_chicken_quinoa.jfif',
  recipe: 'Grill chicken breast and serve with quinoa and steamed vegetables.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Chicken Breast': 200.0, // grams
    'Quinoa': 100.0, // grams
    'Broccoli': 100.0, // grams
  },
),
Meal(
  name: 'Mango and Yogurt Smoothie',
  tag: FitGoals.loseWeight,
  imagePath: 'mango_yogurt_smoothie.jfif',
  recipe: 'Blend Greek yogurt with fresh mango chunks and ice.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Greek Yogurt': 150.0, // grams
    'Mango': 100.0, // grams
  },
),
Meal(
  name: 'Roasted Carrot and Pepper Salad',
  tag: FitGoals.loseWeight,
  imagePath: 'roasted_carrot_pepper_salad.jfif',
  recipe: 'Roast carrots and bell peppers, then toss with fresh greens.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Carrot': 100.0, // grams
    'Pepper': 100.0, // grams
    'Lettuce': 50.0, // grams
  },
),
Meal(
  name: 'Berry and Spinach Smoothie',
  tag: FitGoals.loseWeight,
  imagePath: 'berry_spinach_smoothie.jfif',
  recipe: 'Blend spinach with strawberries, blueberries, and a splash of almond milk.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Spinach': 50.0, // grams
    'Strawberry': 50.0, // grams
    'Blueberry': 50.0, // grams
    'Almonds': 20.0, // grams
  },
),
Meal(
  name: 'Chicken Lettuce Wraps',
  tag: FitGoals.loseWeight,
  imagePath: 'chicken_lettuce_wraps.jfif',
  recipe: 'Grill chicken and wrap in large lettuce leaves with a drizzle of low-fat dressing.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Chicken Breast': 200.0, // grams
    'Lettuce': 100.0, // grams
  },
),

  // Muscle Gain Meals
Meal(
  name: 'Protein Pancakes',
  tag: FitGoals.gainMuscle,
  imagePath: 'protein_pancakes.jfif',
  recipe: 'Mix oats, eggs, and banana to make protein-rich pancakes. Top with Greek yogurt and blueberries.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Oats': 60.0, // grams
    'Eggs': 100.0, // grams
    'Banana': 100.0, // grams
    'Greek Yogurt': 100.0, // grams
    'Blueberry': 50.0, // grams
  },
),
Meal(
  name: 'Chicken and Rice',
  tag: FitGoals.gainMuscle,
  imagePath: 'chicken_rice.jfif',
  recipe: 'Grill chicken breast and serve with steamed rice and broccoli.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Chicken Breast': 200.0, // grams
    'Rice': 100.0, // grams
    'Broccoli': 100.0, // grams
  },
),
Meal(
  name: 'Salmon and Quinoa',
  tag: FitGoals.gainMuscle,
  imagePath: 'salmon_quinoa.jfif',
  recipe: 'Bake salmon and serve with cooked quinoa and steamed spinach.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Salmon': 200.0, // grams
    'Quinoa': 100.0, // grams
    'Spinach': 100.0, // grams
  },
),
Meal(
  name: 'Egg and Avocado Toast',
  tag: FitGoals.gainMuscle,
  imagePath: 'egg_avocado_toast.jfif',
  recipe: 'Top whole grain toast with mashed avocado and a poached egg.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Eggs': 100.0, // grams
    'Avocado': 100.0, // grams
    'Whole Grain Bread': 50.0, // grams
  },
),
Meal(
  name: 'Beef Stir-fry',
  tag: FitGoals.gainMuscle,
  imagePath: 'beef_stirfry.jfif',
  recipe: 'Stir-fry beef with broccoli and bell peppers, served over brown rice.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Beef': 150.0, // grams
    'Broccoli': 100.0, // grams
    'Pepper': 100.0, // grams
    'Rice': 100.0, // grams
  },
),
Meal(
  name: 'Cottage Cheese and Almonds',
  tag: FitGoals.gainMuscle,
  imagePath: 'cottage_cheese_almonds.jfif',
  recipe: 'Mix cottage cheese with almonds and a drizzle of honey.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Cottage Cheese': 150.0, // grams
    'Almonds': 30.0, // grams
  },
),
Meal(
  name: 'Greek Yogurt and Granola',
  tag: FitGoals.gainMuscle,
  imagePath: 'greek_yogurt_granola.jfif',
  recipe: 'Top Greek yogurt with granola and a handful of mixed berries.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Greek Yogurt': 150.0, // grams
    'Granola': 50.0, // grams
    'Mixed Berries': 50.0, // grams
  },
),
Meal(
  name: 'Tuna Salad Sandwich',
  tag: FitGoals.gainMuscle,
  imagePath: 'tuna_salad_sandwich.jfif',
  recipe: 'Mix tuna with Greek yogurt and spread on whole grain bread with lettuce and tomato.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Tuna': 150.0, // grams
    'Greek Yogurt': 50.0, // grams
    'Lettuce': 50.0, // grams
    'Tomato': 100.0, // grams
    'Whole Grain Bread': 100.0, // grams
  },
),
Meal(
  name: 'Omelette with Spinach and Feta',
  tag: FitGoals.gainMuscle,
  imagePath: 'omelette_spinach_feta.jfif',
  recipe: 'Beat eggs and cook with spinach and feta cheese.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Eggs': 100.0, // grams
    'Spinach': 50.0, // grams
    'Cheese': 30.0, // grams
  },
),
Meal(
  name: 'Peanut Butter and Banana Smoothie',
  tag: FitGoals.gainMuscle,
  imagePath: 'peanut_butter_banana_smoothie.jfif',
  recipe: 'Blend peanut butter with a banana, oats, and a scoop of protein powder.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Banana': 100.0, // grams
    'Peanut Butter': 30.0, // grams
    'Oats': 30.0, // grams
  },
),

  Meal(
  name: 'Turkey and Avocado Wrap',
  tag: FitGoals.gainMuscle,
  imagePath: 'turkey_avocado_wrap.jfif',
  recipe: 'Wrap turkey slices, avocado, and spinach in a whole grain tortilla.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Turkey Breast': 150.0, // grams
    'Avocado': 100.0, // grams
    'Spinach': 50.0, // grams
    'Whole Grain Bread': 50.0, // grams
  },
),
Meal(
  name: 'Steak and Sweet Potatoes',
  tag: FitGoals.gainMuscle,
  imagePath: 'steak_sweet_potatoes.jfif',
  recipe: 'Grill steak and serve with baked sweet potatoes and green beans.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Beef': 200.0, // grams
    'Sweet Potato': 150.0, // grams
    'Green Beans': 100.0, // grams
  },
),
Meal(
  name: 'Chocolate Protein Shake',
  tag: FitGoals.gainMuscle,
  imagePath: 'chocolate_protein_shake.jfif',
  recipe: 'Blend chocolate protein powder with almond milk, banana, and a spoonful of peanut butter.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Peanut Butter': 30.0, // grams
    'Banana': 100.0, // grams
    'Almonds': 30.0, // grams
  },
),
Meal(
  name: 'Chicken and Avocado Salad',
  tag: FitGoals.gainMuscle,
  imagePath: 'chicken_avocado_salad.jfif',
  recipe: 'Mix grilled chicken with avocado, spinach, and cherry tomatoes.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Chicken Breast': 150.0, // grams
    'Avocado': 100.0, // grams
    'Spinach': 50.0, // grams
    'Tomato': 100.0, // grams
  },
),
Meal(
  name: 'Almond and Oatmeal Bars',
  tag: FitGoals.gainMuscle,
  imagePath: 'almond_oatmeal_bars.jfif',
  recipe: 'Mix oats with almond butter and bake into bars.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Oats': 100.0, // grams
    'Almonds': 50.0, // grams
  },
),
Meal(
  name: 'Tofu and Quinoa Bowl',
  tag: FitGoals.gainMuscle,
  imagePath: 'tofu_quinoa_bowl.jfif',
  recipe: 'Cook tofu and serve over quinoa with a side of sautéed spinach.',
  category: MealCategoriesEnum.Dinner,
  ingredientNames: {
    'Tofu': 150.0, // grams
    'Quinoa': 100.0, // grams
    'Spinach': 100.0, // grams
  },
),
Meal(
  name: 'Egg White and Veggie Scramble',
  tag: FitGoals.gainMuscle,
  imagePath: 'egg_white_veggie_scramble.jpg',
  recipe: 'Scramble egg whites with spinach, tomatoes, and onions.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Eggs': 100.0, // grams
    'Spinach': 50.0, // grams
    'Tomato': 100.0, // grams
    'Onion': 50.0, // grams
  },
),
Meal(
  name: 'Turkey and Sweet Potato Hash',
  tag: FitGoals.gainMuscle,
  imagePath: 'turkey_sweet_potato_hash.jfif',
  recipe: 'Sauté turkey with diced sweet potatoes and spinach.',
  category: MealCategoriesEnum.Lunch,
  ingredientNames: {
    'Turkey Breast': 150.0, // grams
    'Sweet Potato': 150.0, // grams
    'Spinach': 50.0, // grams
  },
),
Meal(
  name: 'Greek Yogurt Parfait',
  tag: FitGoals.gainMuscle,
  imagePath: 'greek_yogurt_parfait.jfif',
  recipe: 'Layer Greek yogurt with granola and mixed berries in a parfait glass.',
  category: MealCategoriesEnum.Snack,
  ingredientNames: {
    'Greek Yogurt': 150.0, // grams
    'Granola': 50.0, // grams
    'Mixed Berries': 50.0, // grams
  },
),
Meal(
  name: 'Avocado and Cottage Cheese Toast',
  tag: FitGoals.gainMuscle,
  imagePath: 'avocado_cottage_cheese_toast.jfif',
  recipe: 'Spread cottage cheese on toast and top with sliced avocado.',
  category: MealCategoriesEnum.Breakfast,
  ingredientNames: {
    'Cottage Cheese': 100.0, // grams
    'Avocado': 100.0, // grams
    'Whole Grain Bread': 50.0, // grams
  },
),
];
}