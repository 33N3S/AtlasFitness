import 'package:flutter/material.dart';

class MyToggle extends StatefulWidget {
  final bool enabled;
  final Function(int) onGoalChanged;


 MyToggle({ Key? key, required this.enabled, required this.onGoalChanged }) : super(key: key);

  @override
  State<MyToggle> createState() => _MyToggleState();
}

class _MyToggleState extends State<MyToggle> {
  
  late List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context){
    return  Opacity(
      opacity: widget.enabled? 1 : 0.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Center(
            child: ToggleButtons(
              
              borderColor: Theme.of(context).colorScheme.surface,
              fillColor: Theme.of(context).colorScheme.surface,
              borderWidth: 3,
              selectedBorderColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
              isSelected: isSelected,

              onPressed:widget.enabled ? (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
                widget.onGoalChanged(index);
              } : (index){},
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Gain Muscle',
                    style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Loose Weight',
                    style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
      
            ),
          ),
      ),
    );
  }
}