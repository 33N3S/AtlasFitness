import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/daily_intake.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/components/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatefulWidget {

  final Person user;

const MyBarChart({ Key? key, required this.user }) : super(key: key);

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
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
  Widget build(BuildContext context){

    return  FutureBuilder<DailyIntake>(
      future: _dailyIntakeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {

          final dailyIntake = snapshot.data!;

          BarData myBarData = BarData(
            proteinAmount: dailyIntake.nutrients.protein.truncateToDouble(), 
            carbsAmount: dailyIntake.nutrients.carbs.truncateToDouble(), 
            fatsAmount: dailyIntake.nutrients.fats.truncateToDouble(), 
            perfectProteinAmount: widget.user.dailyNeeds.protein.truncateToDouble(),
            perfectCarbsAmount: widget.user.dailyNeeds.carbs.truncateToDouble(),
            perfectFatsAmount: widget.user.dailyNeeds.fats.truncateToDouble()
          );

          myBarData.intializedBarData();

          
          return Center(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer
            ),
            height: 300,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show:false),
                borderData: FlBorderData(show:false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget:getBottomTitles)
                  )
                ),
                minY: 0,
                maxY:(widget.user.dailyNeeds.carbs + 10 + 9) ~/ 10 * 10 +10,
                barGroups: myBarData.barData.map((data)=> 
                BarChartGroupData(
                  x:data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.perfect,
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 30,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  BarChartRodData(
                    toY: data.actual,
                    color: Theme.of(context).colorScheme.primary,
                    width: 30,
                    borderRadius: BorderRadius.circular(5)
      
                    )
                  ]
                )).toList()
              )
            ),
          ),
      );
        }
        else {
          return const Center(child: Text('No data available.'));
          }
        }
    );
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
      text = Text("Protein", style: style);
      break;
    case 1:
      text = Text("Carbs", style: style);
      break;
    case 2:
      text = Text("Fats", style: style);
      break;
    default:
      text = Text("", style: style); // default case
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

}