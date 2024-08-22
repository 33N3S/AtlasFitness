enum MealCategoriesEnum {
  Breakfast,
  Lunch,
  Dinner,
  Snack,
}

extension MealCategoriesEnumExtension on MealCategoriesEnum {
  String get name {
    switch (this) {
      case MealCategoriesEnum.Breakfast:
        return 'Breakfast';
      case MealCategoriesEnum.Lunch:
        return 'Lunch';
      case MealCategoriesEnum.Dinner:
        return 'Dinner';
      case MealCategoriesEnum.Snack:
        return 'Snack';
      default:
        return '';
    }
  }

  static MealCategoriesEnum fromString(String category) {
    switch (category) {
      case 'Breakfast':
        return MealCategoriesEnum.Breakfast;
      case 'Lunch':
        return MealCategoriesEnum.Lunch;
      case 'Dinner':
        return MealCategoriesEnum.Dinner;
      case 'Snack':
        return MealCategoriesEnum.Snack;
      default:
        throw ArgumentError('Invalid category: $category');
    }
  }


  
}

