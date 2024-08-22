enum FoodCategoriesEnum {
  Fruits,
  Vegetables,
  Grains,
  Proteins,
  Dairy,
  NutsAndSeeds,
  Seafood,
  Legumes,
  Miscellaneous
}

extension FoodCategoriesEnumExtension on FoodCategoriesEnum {
  String get name {
    switch (this) {
      case FoodCategoriesEnum.Fruits:
        return 'Fruits';
      case FoodCategoriesEnum.Vegetables:
        return 'Vegetables';
      case FoodCategoriesEnum.Grains:
        return 'Grains';
      case FoodCategoriesEnum.Proteins:
        return 'Proteins';
      case FoodCategoriesEnum.Dairy:
        return 'Dairy';
      case FoodCategoriesEnum.NutsAndSeeds:
        return 'NutsAndSeeds';
      case FoodCategoriesEnum.Seafood:
        return 'Seafood';
      case FoodCategoriesEnum.Legumes:
        return 'Legumes';
      case FoodCategoriesEnum.Miscellaneous:
        return 'Miscellaneous';
      default:
        return '';
    }
  }

  static FoodCategoriesEnum fromString(String category) {
    switch (category) {
      case 'Fruits':
        return FoodCategoriesEnum.Fruits;
      case 'Vegetables':
        return FoodCategoriesEnum.Vegetables;
      case 'Grains':
        return FoodCategoriesEnum.Grains;
      case 'Proteins':
        return FoodCategoriesEnum.Proteins;
      case 'Dairy':
        return FoodCategoriesEnum.Dairy;
      case 'NutsAndSeeds':
        return FoodCategoriesEnum.NutsAndSeeds;
      case 'Seafood':
        return FoodCategoriesEnum.Seafood;
      case 'Legumes':
        return FoodCategoriesEnum.Legumes;
      case 'Miscellaneous':
        return FoodCategoriesEnum.Miscellaneous;
      default:
        throw ArgumentError('Invalid category: $category');
    }
  }
}

