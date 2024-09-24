import 'package:atlas_fitness/backend/model/nutrients.dart';

class DailyIntake {
  final Nutrients nutrients;
  final DateTime date;

  DailyIntake({
    required this.nutrients,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'nutrients': nutrients.toMap(),
    };
  }

  factory DailyIntake.fromDocumentSnapshot(Map<String, dynamic>? data) {
    return DailyIntake(
      nutrients: Nutrients.fromMap(data?['nutrients']),
      date: DateTime.parse(data?['date']),
    );
  }

}
