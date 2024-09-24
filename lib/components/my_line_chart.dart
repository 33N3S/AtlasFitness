import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BurnedCaloriesLineChart extends StatefulWidget {
  final Person user;

  const BurnedCaloriesLineChart({required this.user});

  @override
  State<BurnedCaloriesLineChart> createState() => _BurnedCaloriesLineChartState();
}

class _BurnedCaloriesLineChartState extends State<BurnedCaloriesLineChart> {
  late Future<List<DailyIntake>> weeklyBurnedCalories;

  @override
  void initState() {
    super.initState();
    weeklyBurnedCalories = FirestoreService().getBurnedCalsForCurrentWeek();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyIntake>>(
      future: weeklyBurnedCalories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        List<DailyIntake> weeklyData = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false
                        )
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTitlesWidget: (value, meta) {
                            var style = TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            );

                            String day = formatDateToDay(DateTime.now().subtract(
                              Duration(days: DateTime.now().weekday - 1 - value.toInt()),
                            ));

                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(day, style: style),
                            );
                          },
                          interval: 1,
                        ),
                      ),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 0,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            );
                          },
                          interval: 100,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: ((weeklyData
                        .map((e) => e.nutrients.calories.toDouble())
                        .reduce((a, b) => a > b ? a : b) + 100) / 10).ceil() * 10 -50,

                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(weeklyData.length, (index) {
                          return FlSpot(
                            index.toDouble(),
                            weeklyData[index].nutrients.calories.toDouble(),
                          );
                        }),
                        isCurved: true,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(show: true,color: Theme.of(context).colorScheme.tertiary),
                        color: Theme.of(context).colorScheme.primary,
                        barWidth: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDateToDay(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }


}
