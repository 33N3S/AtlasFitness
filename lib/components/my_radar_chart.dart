import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyRadarChart extends StatefulWidget {
  MyRadarChart({super.key});

  final gridColor = const Color.fromARGB(255, 36, 28, 38).withOpacity(0.2);
  final titleColor = const Color.fromARGB(255, 50, 47, 51).withOpacity(0.3);
  final perfectColor = Color.fromARGB(255, 151, 151, 151).withOpacity(0.4);
  final actualColor = Colors.blue;

  @override
  State<MyRadarChart> createState() => _MyRadarChartState();
}

class _MyRadarChartState extends State<MyRadarChart> {
  int selectedDataSetIndex = -1;
  double angleValue = 30;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.1,
                  child: RadarChart(
                    RadarChartData(
                      dataSets: showingDataSets(),
                      radarBackgroundColor: Colors.transparent,
                      borderData: FlBorderData(show: false),
                      radarBorderData: const BorderSide(color: Colors.transparent),
                      titlePositionPercentageOffset: 0.3,
                      titleTextStyle:
                          TextStyle(color: widget.titleColor, fontSize: 14),
                      getTitle: (index, angle) {
                        final usedAngle =
                            relativeAngleMode ? angle + angleValue : angleValue;
                        switch (index) {
                          case 0:
                            return RadarChartTitle(
                              text: 'Proteins',
                              angle: usedAngle,
                            );
                          case 1:
                            return RadarChartTitle(
                              text: 'Carbs',
                              angle: usedAngle,
                            );
                          case 2:
                            return RadarChartTitle(
                              text: 'Fats',
                              angle: usedAngle,
                            );
                          default:
                            return const RadarChartTitle(text: 'Daily Intake');
                        }
                      },
                      tickCount: 1,
                      ticksTextStyle:
                          const TextStyle(color: Color.fromARGB(0, 0, 0, 0), fontSize: 10),
                      tickBorderData: const BorderSide(color: Color.fromARGB(9, 0, 0, 0)),
                      gridBorderData: BorderSide(color: widget.gridColor, width: 2),
            
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return [
      RadarDataSet(
        fillColor: widget.perfectColor.withOpacity(0.2),
        borderColor: widget.perfectColor.withOpacity(0.8),
        entryRadius: 3,
        dataEntries: [
          RadarEntry(value: 100), // Perfect Proteins
          RadarEntry(value: 200), // Perfect Carbs
          RadarEntry(value: 70),  // Perfect Fats
        ],
        borderWidth: 2,
      ),
      RadarDataSet(
        fillColor: widget.actualColor.withOpacity(0.4),
        borderColor: widget.actualColor,
        entryRadius: 4,
        dataEntries: [
          RadarEntry(value: 40),  // Actual Proteins
          RadarEntry(value: 230), // Actual Carbs
          RadarEntry(value: 30),  // Actual Fats
        ],
        borderWidth: 2,
      ),
    ];
  }
}