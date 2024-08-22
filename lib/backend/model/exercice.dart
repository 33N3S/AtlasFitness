
enum ExerciceType {
  Cardio,
  Strength,
  Flexibility,
  Balance
}

class Exercice {
  final String name;
  late double duration; // in seconds
  final ExerciceType type;
  final String description;
  final double caloriesPerSecond;
  final List<String> targetMuscles;

  Exercice({
    required this.targetMuscles,
    required this.type,
    required this.description,
    required this.name,
    required this.duration,
    required this.caloriesPerSecond,
  });

  factory Exercice.fromMap(Map<String, dynamic> doc) {
    return Exercice(
      name: doc['name'],
      duration: doc['duration'],
      type: ExerciceType.values.firstWhere((e) => e.toString() == 'ExerciceType.${doc['type']}'),
      description: doc['description'],
      caloriesPerSecond: doc['caloriesPerSecond'],
      targetMuscles: List<String>.from(doc['targetMuscles']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'type': type.toString().split('.').last, // Store only the enum name
      'description': description,
      'caloriesPerSecond': caloriesPerSecond,
      'targetMuscles': targetMuscles,
    };
  }
}
