import 'package:atlas_fitness/backend/model/exercice.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';
import 'package:atlas_fitness/backend/model/workout.dart';
import 'package:flutter/cupertino.dart';

class WorkoutBase extends ChangeNotifier{
    static List<Exercice> muscleGainExercises = [
    Exercice(
      name: 'Bench Press',
      duration: 60, // in seconds
      type: ExerciceType.Strength,
      description: 'A barbell exercise for the chest.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Chest', 'Triceps', 'Shoulders'],
    ),
    Exercice(
      name: 'Pull-Up',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A bodyweight exercise for the back.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Back', 'Biceps'],
    ),
    Exercice(
      name: 'Shoulder Press',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise to strengthen the shoulders.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Shoulders', 'Triceps'],
    ),
    Exercice(
      name: 'Dumbbell Row',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise for the back.',
      caloriesPerSecond: 0.11,
      targetMuscles: ['Back', 'Biceps'],
    ),
    Exercice(
      name: 'Chest Fly',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise focusing on the chest muscles.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Chest'],
    ),
    Exercice(
      name: 'Tricep Dips',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise for the triceps.',
      caloriesPerSecond: 0.09,
      targetMuscles: ['Triceps', 'Chest'],
    ),
  ];

  // Define exercises for weight loss workout
  static List<Exercice> weightLossExercises = [
    Exercice(
      name: 'Running',
      duration: 600, // in seconds
      type: ExerciceType.Cardio,
      description: 'High-intensity running exercise.',
      caloriesPerSecond: 0.15,
      targetMuscles: ['Legs', 'Cardio'],
    ),
    Exercice(
      name: 'Jump Rope',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A cardio exercise using a rope.',
      caloriesPerSecond: 0.14,
      targetMuscles: ['Legs', 'Cardio'],
    ),
    Exercice(
      name: 'Burpees',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A full-body exercise with jumps.',
      caloriesPerSecond: 0.16,
      targetMuscles: ['Full Body', 'Cardio'],
    ),
    Exercice(
      name: 'Mountain Climbers',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A full-body cardio exercise.',
      caloriesPerSecond: 0.14,
      targetMuscles: ['Full Body', 'Cardio'],
    ),
    Exercice(
      name: 'High Knees',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A high-intensity cardio exercise.',
      caloriesPerSecond: 0.13,
      targetMuscles: ['Legs', 'Cardio'],
    ),
    Exercice(
      name: 'Cycling',
      duration: 600,
      type: ExerciceType.Cardio,
      description: 'A cardio workout using a bicycle.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Legs', 'Cardio'],
    ),
  ];


  static List<Exercice> lowerBodyMuscleGainExercises = [
    Exercice(
      name: 'Squats',
      duration: 60, // in seconds
      type: ExerciceType.Strength,
      description: 'A fundamental exercise for the lower body.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Quads', 'Hamstrings', 'Glutes'],
    ),
    Exercice(
      name: 'Lunges',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise targeting the quads and glutes.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Quads', 'Glutes', 'Hamstrings'],
    ),
    Exercice(
      name: 'Leg Press',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A machine-based exercise for leg strength.',
      caloriesPerSecond: 0.11,
      targetMuscles: ['Quads', 'Glutes', 'Hamstrings'],
    ),
    Exercice(
      name: 'Deadlifts',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A compound exercise that works the lower body and back.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Hamstrings', 'Glutes', 'Lower Back'],
    ),
    Exercice(
      name: 'Leg Curls',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An isolation exercise for the hamstrings.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Hamstrings'],
    ),
    Exercice(
      name: 'Calf Raises',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise for strengthening the calves.',
      caloriesPerSecond: 0.09,
      targetMuscles: ['Calves'],
    ),
    Exercice(
      name: 'Bulgarian Split Squats',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A single-leg exercise focusing on the quads and glutes.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Quads', 'Glutes', 'Hamstrings'],
    ),
  ];

  // Define exercises for weight loss workout (different from previous)
  static List<Exercice> newWeightLossExercises = [
    Exercice(
      name: 'Elliptical Trainer',
      duration: 600, // in seconds
      type: ExerciceType.Cardio,
      description: 'A low-impact cardio workout on an elliptical machine.',
      caloriesPerSecond: 0.13,
      targetMuscles: ['Cardio', 'Legs'],
    ),
    Exercice(
      name: 'Rowing Machine',
      duration: 600,
      type: ExerciceType.Cardio,
      description: 'A full-body cardio workout using a rowing machine.',
      caloriesPerSecond: 0.14,
      targetMuscles: ['Cardio', 'Full Body'],
    ),
    Exercice(
      name: 'Jumping Jacks',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A cardio exercise that involves jumping and spreading the legs.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Cardio', 'Legs', 'Full Body'],
    ),
    Exercice(
      name: 'Burpee Box Jumps',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A high-intensity cardio exercise combining burpees and box jumps.',
      caloriesPerSecond: 0.15,
      targetMuscles: ['Full Body', 'Cardio'],
    ),
    Exercice(
      name: 'Battle Ropes',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A cardio exercise using heavy ropes.',
      caloriesPerSecond: 0.16,
      targetMuscles: ['Cardio', 'Arms'],
    ),
    Exercice(
      name: 'Sprints',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'Short bursts of high-intensity running.',
      caloriesPerSecond: 0.17,
      targetMuscles: ['Legs', 'Cardio'],
    ),
    Exercice(
      name: 'Kettlebell Swings',
      duration: 300,
      type: ExerciceType.Cardio,
      description: 'A dynamic exercise using a kettlebell.',
      caloriesPerSecond: 0.14,
      targetMuscles: ['Full Body', 'Cardio'],
    ),
  ];


  static List<Exercice> fullBodyMuscleGainExercises = [
    Exercice(
      name: 'Deadlifts',
      duration: 60, // in seconds
      type: ExerciceType.Strength,
      description: 'A compound exercise that targets the whole body, focusing on the back and legs.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Back', 'Hamstrings', 'Glutes', 'Core'],
    ),
    Exercice(
      name: 'Bench Press',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A chest exercise that also engages the shoulders and triceps.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Chest', 'Shoulders', 'Triceps'],
    ),
    Exercice(
      name: 'Pull-Ups',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise for the back and biceps.',
      caloriesPerSecond: 0.12,
      targetMuscles: ['Back', 'Biceps'],
    ),
    Exercice(
      name: 'Squats',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A fundamental lower body exercise that also engages the core.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Quads', 'Glutes', 'Hamstrings', 'Core'],
    ),
    Exercice(
      name: 'Overhead Press',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise for the shoulders, triceps, and upper chest.',
      caloriesPerSecond: 0.11,
      targetMuscles: ['Shoulders', 'Triceps', 'Chest'],
    ),
    Exercice(
      name: 'Bent Over Rows',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'An exercise targeting the upper back and biceps.',
      caloriesPerSecond: 0.11,
      targetMuscles: ['Back', 'Biceps'],
    ),
    Exercice(
      name: 'Lunges',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A lower body exercise focusing on the quads and glutes.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Quads', 'Glutes', 'Hamstrings'],
    ),
    Exercice(
      name: 'Dumbbell Bench Press',
      duration: 60,
      type: ExerciceType.Strength,
      description: 'A chest exercise that targets the upper body with dumbbells.',
      caloriesPerSecond: 0.1,
      targetMuscles: ['Chest', 'Triceps', 'Shoulders'],
    ),
  ];

  // Define exercises for weight loss flexibility workout
  static List<Exercice> flexibilityWeightLossExercises = [
    Exercice(
      name: 'Yoga Sun Salutations',
      duration: 600, // in seconds
      type: ExerciceType.Flexibility,
      description: 'A series of yoga poses to improve flexibility and endurance.',
      caloriesPerSecond: 0.08,
      targetMuscles: ['Full Body'],
    ),
    Exercice(
      name: 'Hamstring Stretch',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A stretching exercise focusing on the hamstrings.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Hamstrings'],
    ),
    Exercice(
      name: 'Hip Flexor Stretch',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A stretch targeting the hip flexors.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Hip Flexors'],
    ),
    Exercice(
      name: 'Cat-Cow Stretch',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A yoga pose that helps improve spine flexibility.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Spine', 'Core'],
    ),
    Exercice(
      name: 'Child’s Pose',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A resting pose that stretches the back and hips.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Back', 'Hips'],
    ),
    Exercice(
      name: 'Standing Quad Stretch',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A stretch for the quadriceps muscles.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Quads'],
    ),
    Exercice(
      name: 'Seated Forward Bend',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A stretch focusing on the hamstrings and lower back.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Hamstrings', 'Lower Back'],
    ),
    Exercice(
      name: 'Butterfly Stretch',
      duration: 300,
      type: ExerciceType.Flexibility,
      description: 'A stretch for the inner thighs and hips.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Inner Thighs', 'Hips'],
    ),
  ];
  // Define exercises for balance workout
  static List<Exercice> balanceExercises = [
    Exercice(
      name: 'Single-Leg Balance',
      duration: 60, // in seconds per leg
      type: ExerciceType.Balance,
      description: 'Balancing on one leg to improve stability.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Legs', 'Core'],
    ),
    Exercice(
      name: 'Tai Chi',
      duration: 600,
      type: ExerciceType.Balance,
      description: 'A form of martial arts focusing on slow, deliberate movements for balance.',
      caloriesPerSecond: 0.07,
      targetMuscles: ['Full Body'],
    ),
    Exercice(
      name: 'Standing Leg Lifts',
      duration: 60, // in seconds per leg
      type: ExerciceType.Balance,
      description: 'Lifting one leg at a time while maintaining balance.',
      caloriesPerSecond: 0.06,
      targetMuscles: ['Legs', 'Core'],
    ),
    Exercice(
      name: 'Bosu Ball Squats',
      duration: 60, // in seconds
      type: ExerciceType.Balance,
      description: 'Performing squats on a Bosu ball to enhance balance and stability.',
      caloriesPerSecond: 0.08,
      targetMuscles: ['Legs', 'Core'],
    ),
    Exercice(
      name: 'Balance Board Exercises',
      duration: 60, // in seconds
      type: ExerciceType.Balance,
      description: 'Exercises performed on a balance board to improve stability.',
      caloriesPerSecond: 0.07,
      targetMuscles: ['Legs', 'Core'],
    ),
    Exercice(
      name: 'Heel-to-Toe Walk',
      duration: 300,
      type: ExerciceType.Balance,
      description: 'Walking in a straight line with heel-to-toe steps to improve balance.',
      caloriesPerSecond: 0.05,
      targetMuscles: ['Legs', 'Core'],
    ),
    Exercice(
      name: 'Plank with Arm Lift',
      duration: 60, // in seconds
      type: ExerciceType.Balance,
      description: 'Holding a plank position while lifting one arm to challenge balance.',
      caloriesPerSecond: 0.08,
      targetMuscles: ['Core', 'Shoulders'],
    ),
    Exercice(
      name: 'Yoga Tree Pose',
      duration: 60, // in seconds per leg
      type: ExerciceType.Balance,
      description: 'A yoga pose that requires standing on one leg and placing the other foot on the inner thigh.',
      caloriesPerSecond: 0.07,
      targetMuscles: ['Legs', 'Core'],
    ),
  ];


  static final List<Exercice> allExercises = [
    ...muscleGainExercises,
    ...weightLossExercises,
    ...lowerBodyMuscleGainExercises,
    ...newWeightLossExercises,
    ...fullBodyMuscleGainExercises,
    ...flexibilityWeightLossExercises,
    ...balanceExercises,
  ];

  static List<Exercice> selectedExercices = [];
  static List<Exercice> selectedCustomExercices = [];


  void addExerciceItem(Exercice exercice,List<Exercice> list) {
    list.add(exercice);
    notifyListeners(); 
  }

  void removeexerciceItem(Exercice exercice,List<Exercice> list) {
    list.remove(exercice);
    notifyListeners(); 
  }
  

  // Define the workouts
  static List<Workout> workouts = [

    Workout(
      imagePath: 'upper_body.jfif',
      name: 'Upper Body Muscle Gain Workout',
      exercices: muscleGainExercises,
      tag: FitGoals.gainMuscle,
      type: ExerciceType.Strength,
    ),
    Workout(
      imagePath: 'cardio.jfif',
      name: 'Weight Loss Cardio Workout',
      exercices: weightLossExercises,
      tag: FitGoals.loseWeight,
      type: ExerciceType.Cardio,
    ),
     Workout(
      imagePath: 'lower_body.jfif',
      name: 'Lower Body Muscle Gain Workout',
      exercices: lowerBodyMuscleGainExercises,
      tag: FitGoals.gainMuscle,
      type: ExerciceType.Strength,
    ),
    Workout(
      imagePath: 'cardio_advanced.jfif',
      name: 'Advanced Weight Loss Cardio Workout',
      exercices: newWeightLossExercises,
      tag: FitGoals.loseWeight,
      type: ExerciceType.Cardio,
    ),
    Workout(
      imagePath: 'full_body.jfif',
      name: 'Full Body Muscle Gain Workout',
      exercices: fullBodyMuscleGainExercises,
      tag: FitGoals.gainMuscle,
      type: ExerciceType.Strength,
    ),
    Workout(
      imagePath: 'flexibility.jfif',
      name: 'Flexibility Weight Loss Workout',
      exercices: flexibilityWeightLossExercises,
      tag: FitGoals.loseWeight,
      type: ExerciceType.Flexibility,
    ),
    Workout(
      imagePath: 'balance.jfif',
      name: 'Balance Workout',
      exercices: balanceExercises,
      tag: FitGoals.loseWeight, // Balance workouts can contribute to weight loss indirectly
      type: ExerciceType.Balance,
    ),
  ];

}