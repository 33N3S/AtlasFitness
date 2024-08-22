import 'package:atlas_fitness/backend/model/exercice.dart';
import 'package:atlas_fitness/backend/model/workout_base.dart';
import 'package:atlas_fitness/components/my_register_button.dart';
import 'package:atlas_fitness/components/my_text_field.dart';
import 'package:flutter/material.dart';


class MyExerciceSelector extends StatefulWidget {
  final TextEditingController searchController;
  final List<Exercice> exerices;
  final List<Exercice> selectedExercices;

  MyExerciceSelector({
    Key? key,
    required this.searchController,
    required this.exerices, 
    required this.selectedExercices,
  }) : super(key: key);

  @override
  _MyExerciceSelectorState createState() => _MyExerciceSelectorState();
}

class _MyExerciceSelectorState extends State<MyExerciceSelector> {
  String _searchQuery = '';
  String _selectedCategory = '';
  late Map<String, List<Exercice>> categorizedExercices;

  @override
  void initState() {
    super.initState();
    categorizedExercices = _categorizeExercices(widget.exerices);
    _selectedCategory = categorizedExercices.keys.first;
    widget.searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = widget.searchController.text.toLowerCase();
    });
  }

  Map<String, List<Exercice>> _categorizeExercices(List<Exercice> exerices) {
    Map<String, List<Exercice>> categorizedItems = {};

    for (var exerices in exerices) {
      String category = exerices.type.name;
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(exerices);
    }

    return categorizedItems;
  }

  List<Exercice> _getFilteredexerices() {
    List<Exercice> exerices = categorizedExercices[_selectedCategory] ?? [];
    if (_searchQuery.isNotEmpty) {
      exerices = exerices
          .where((exercice) => exercice.name.toLowerCase().contains(_searchQuery))
          .toList();
    }
    return exerices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MyTextField(
            controller: widget.searchController,
            hintText: "Search in category",
            obscureText: false,
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: DefaultTabController(
              length: categorizedExercices.keys.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    onTap: (index) {
                      setState(() {
                        _selectedCategory =
                            categorizedExercices.keys.elementAt(index);
                      });
                    },
                    tabs: categorizedExercices.keys
                        .map((category) => Tab(text: category))
                        .toList(),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: categorizedExercices.keys.map((category) {
                        return ListView(
                          children: _getFilteredexerices()
                              .map((exerciceItem) => ExpansionTile(
                                    title: Text(exerciceItem.name),
                                    children: [
                                      _buildMacronutrientRow(
                                          "CalsPerSec",
                                          exerciceItem.caloriesPerSecond),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 80,right:15,top: 10,bottom: 10),
                                        child: MyRegisterButton(text: "Add", onTap: (){
                                              WorkoutBase().addExerciceItem(exerciceItem,widget.selectedExercices); 
                                              Navigator.pop(context);
                                        }),
                                      )
                                    ],
                                  ))
                              .toList(),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacronutrientRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
