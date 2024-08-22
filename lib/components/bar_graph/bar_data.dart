import 'package:atlas_fitness/components/bar_graph/individua_bar.dart';

class BarData{

  final double proteinAmount;
  final double carbsAmount;
  final double fatsAmount;

  final double perfectProteinAmount;
  final double perfectCarbsAmount;
  final double perfectFatsAmount;

  BarData({
    required this.proteinAmount, 
    required this.carbsAmount, 
    required this.fatsAmount,
    required this.perfectProteinAmount,
    required this.perfectCarbsAmount,
    required this.perfectFatsAmount});

  List<IndividuaBar> barData = [];

  void intializedBarData(){
    barData = [
        IndividuaBar(x:0,actual: proteinAmount, perfect: perfectProteinAmount),
        IndividuaBar(x:1,actual: carbsAmount, perfect: perfectCarbsAmount),
        IndividuaBar(x:2,actual: fatsAmount, perfect: perfectFatsAmount),
    ];
  }
  
}
