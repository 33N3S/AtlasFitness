import 'package:flutter/material.dart';
import 'package:atlas_fitness/backend/model/goals_enum.dart';

class ProfileToggle extends StatefulWidget {
  final bool enabled;
  final Function(int) onGoalChanged;
  final FitGoals selectedGoal;  // New parameter for the selected goal

  ProfileToggle({
    Key? key,
    required this.enabled,
    required this.onGoalChanged,
    required this.selectedGoal,  // Initialize the parameter
  }) : super(key: key);

  @override
  State<ProfileToggle> createState() => _ProfileToggleState();
}

class _ProfileToggleState extends State<ProfileToggle> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    // Set initial state based on the selectedGoal
    isSelected = [
      widget.selectedGoal == FitGoals.gainMuscle,
      widget.selectedGoal == FitGoals.loseWeight,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1 : 0.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Center(
          child: ToggleButtons(
            borderColor: Theme.of(context).colorScheme.secondary,
            fillColor: Theme.of(context).colorScheme.secondary,
            borderWidth: 3,
            selectedBorderColor: Theme.of(context).colorScheme.secondary,
            selectedColor: Theme.of(context).colorScheme.inversePrimary,
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
            isSelected: isSelected,
            onPressed: widget.enabled
                ? (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                    widget.onGoalChanged(index);
                  }
                : (index) {},
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Gain Muscle',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Lose Weight',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
