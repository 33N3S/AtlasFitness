import 'package:atlas_fitness/backend/model/food_categories_enum.dart';
import 'package:atlas_fitness/backend/model/nutrients.dart';

class Food {
  final String name;
  final Nutrients nutrients;
  final FoodCategoriesEnum category;

  Food({
    required this.name,
    required this.nutrients,
    required this.category,
  });

  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      name: data['name'],
      nutrients: Nutrients.fromMap(data['nutrients']),
      category: FoodCategoriesEnumExtension.fromString(data['category']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nutrients': nutrients.toMap(),
      'category': category.name,
    };
  }
}
