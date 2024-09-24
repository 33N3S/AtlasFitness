import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyIntakeBarChart extends StatefulWidget {
  final Person user;

  const DailyIntakeBarChart({required this.user});

  @override
  State<DailyIntakeBarChart> createState() => _DailyIntakeBarChartState();
}

class _DailyIntakeBarChartState extends State<DailyIntakeBarChart> {
  late Future<List<DailyIntake>> weekly_intakes;

  bool isInCurrentWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Start of the current week (Monday)
    final endOfWeek = startOfWeek.add(Duration(days: 7)); // End of the current week (Sunday)
    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text("Mon", style: style);
        break;
      case 1:
        text = Text("Tue", style: style);
        break;
      case 2:
        text = Text("Wed", style: style);
        break;
      case 3:
        text = Text("Thu", style: style);
        break;
      case 4:
        text = Text("Fri", style: style);
        break;
      case 5:
        text = Text("Sat", style: style);
        break;
      case 6:
        text = Text("Sun", style: style);
        break;
      default:
        text = Text("", style: style); // default case
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  @override
  void initState() {
    super.initState();
    weekly_intakes = FirestoreService().getDailyIntakesForCurrentWeek();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyIntake>>(
      future: weekly_intakes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading data"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No data available"));
        }

        final currentWeekIntake = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: Column(
            children: [
              Container(
                height: 280,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomTitles,
                        ),
                      ),
                    ),
                    barGroups: _buildBarGroups(currentWeekIntake),
                  ),
                ),
              ),
              const SizedBox(height: 17), // Space between chart and legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(
                    color: Theme.of(context).colorScheme.tertiary,
                    label: 'Proteins',
                  ),
                  const SizedBox(width: 15),
                  _buildLegendItem(
                    color: Theme.of(context).colorScheme.primary,
                    label: 'Carbs',
                  ),
                  const SizedBox(width: 15),
                  _buildLegendItem(
                    color: Theme.of(context).colorScheme.secondary,
                    label: 'Fats',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<DailyIntake> currentWeekIntake) {
    return List.generate(currentWeekIntake.length, (index) {
      final nutrients = currentWeekIntake[index].nutrients;
      final totalCalories = nutrients.totalCalories;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: totalCalories,
            rodStackItems: [
              BarChartRodStackItem(
                0,
                nutrients.protein * 4,
                Theme.of(context).colorScheme.tertiary,
              ), // Proteins
              BarChartRodStackItem(
                nutrients.protein * 4,
                nutrients.protein * 4 + nutrients.carbs * 4,
                Theme.of(context).colorScheme.primary,
              ), // Carbs
              BarChartRodStackItem(
                nutrients.protein * 4 + nutrients.carbs * 4,
                totalCalories,
                Theme.of(context).colorScheme.secondary,
              ), // Fats
            ],
            borderRadius: BorderRadius.circular(5),
            width: 28,
          ),
        ],
      );
    });
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
