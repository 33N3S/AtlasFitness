import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatefulWidget {
  final Person user;

  const MyPieChart({Key? key, required this.user}) : super(key: key);

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  late FirestoreService _firestoreService;
  late Future<DailyIntake> _dailyIntakeFuture;

  @override
  void initState() {
    super.initState();
    _firestoreService = FirestoreService();
    _dailyIntakeFuture = _fetchDailyIntake();
  }

  Future<DailyIntake> _fetchDailyIntake() async {
    DateTime today = DateTime.now();
    return await _firestoreService.getIntakeByDate(today);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DailyIntake>(
      future: _dailyIntakeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final dailyIntake = snapshot.data!;
          final double currentCalories = dailyIntake.nutrients.calories;
          final double perfectCalories = widget.user.tarGetCalNeed.truncateToDouble();
          final double remainingCalories = perfectCalories - currentCalories;
          final bool isExceeded = remainingCalories < 0;
          final double displayedCalories = isExceeded ? perfectCalories : currentCalories;

          final chartNumStyle = TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.surface,
          );

          final bottomTitleStyle = TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          );

          return Center(
            child: Container(
              height: 400,
              padding: EdgeInsets.only(top: 180),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Column(
                children: [
                  Container(
                    height: 20,
                    child: PieChart(
                      swapAnimationCurve: Curves.easeInOutCubic,
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        startDegreeOffset: 0,
                        sections: [
                          PieChartSectionData(
                            color: Colors.transparent,
                            value: 50,
                            showTitle: false,
                            radius: 100,
                          ),
                          PieChartSectionData(
                            color: Theme.of(context).colorScheme.primary,
                            value: (isExceeded ? perfectCalories : currentCalories) / ((isExceeded ? ( perfectCalories - remainingCalories) : perfectCalories) * 2) * 100,
                            showTitle: true,
                            radius: 100,
                            title: displayedCalories.toStringAsFixed(0),
                            titleStyle: chartNumStyle,
                          ),
                          PieChartSectionData(
                            color: isExceeded
                                ? Colors.red
                                : Theme.of(context).colorScheme.tertiary,
                            value: ((isExceeded? -remainingCalories : remainingCalories) / ( (isExceeded ? (perfectCalories - remainingCalories) : perfectCalories) * 2)) * 100,
                            showTitle: true,
                            radius: 100,
                            title: (-remainingCalories).toStringAsFixed(0),
                            titleStyle: chartNumStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isExceeded ? "Perfect Intake" : "Your Consumption", style: bottomTitleStyle),
                        Text(isExceeded ? "Your Surplus" : "Remaining Calories", style: bottomTitleStyle),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Opacity(
                      opacity: 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Swipe for Nutrition Details", style: TextStyle(fontSize: 12)),
                          SizedBox(width: 5),
                          Icon(CupertinoIcons.arrow_right, size: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Return a widget when there's no data
          return Center(child: Text('No data available.'));
        }
      },
    );
  }
}
