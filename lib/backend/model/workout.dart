import 'package:atlas_fitness/backend/model/exercice.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';

class Workout {
  final String name;
  final List<Exercice> exercices;
  final FitGoals tag;
  final ExerciceType type;
  late List<String> targetMuscles;
  late double totalDuration;
  late double totalBurnedCalories;
  final String imagePath;

  Workout({
    required this.type,
    required this.name,
    required this.exercices,
    required this.tag,
    required this.imagePath,
    this.totalDuration = 0.0,
    this.totalBurnedCalories = 0.0,
  }) {
    _initializeValues();
  }

  void _initializeValues() {
    totalDuration = exercices.fold(0.0, (sum, exercice) => sum + exercice.duration);
    totalBurnedCalories = exercices.fold(0.0, (sum, exercice) => sum + (exercice.caloriesPerSecond * exercice.duration));
    
    targetMuscles = exercices
        .expand((exercice) => exercice.targetMuscles)
        .toSet()
        .toList();
  }

  factory Workout.fromMap(Map<String, dynamic> doc) {
    // Parse the exercices list
    List<Exercice> exercicesList = (doc['exercices'] as List<dynamic>)
        .map((e) => Exercice.fromMap(e))
        .toList();

    // Parse the targetMuscles list
    List<String> targetMusclesList = List<String>.from(doc['targetMuscles']);

    return Workout(
      name: doc['name'],
      exercices: exercicesList,
      tag: FitGoals.values.firstWhere((e) => e.toString() == 'FitGoals.${doc['tag']}'),
      type: ExerciceType.values.firstWhere((e) => e.toString() == 'ExerciceType.${doc['type']}'),
      imagePath: doc['imagePath'],
    )
    ..targetMuscles = targetMusclesList
    ..totalBurnedCalories = doc['totalBurnedCalories']
    ..totalDuration = doc['totalDuration'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercices': exercices.map((e) => e.toMap()).toList(),
      'tag': tag.toString().split('.').last, // Store only the enum name
      'type': type.toString().split('.').last, // Store only the enum name
      'imagePath': imagePath,
      'totalDuration':totalDuration,
      'totalBurnedCalories':totalBurnedCalories,
      'targetMuscles':targetMuscles
    };
  }
}
