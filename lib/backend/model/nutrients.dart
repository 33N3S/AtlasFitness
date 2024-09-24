class Nutrients {
  double calories;
  double protein; // in grams
  double carbs;   // in grams
  double fats;    // in grams

  Nutrients({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory Nutrients.fromMap(Map<String, dynamic> map) {
    return Nutrients(
      calories: map['calories'],
      protein: map['protein'],
      carbs: map['carbs'],
      fats: map['fats'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  double get totalCalories => (protein * 4) + (carbs * 4) + (fats * 9);

}