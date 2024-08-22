import 'package:flutter/material.dart';

class MyActivitySlider extends StatefulWidget {
  final double initialRatio;
  final Function(double) onRatioChanged;
  final bool enabled;

  MyActivitySlider({Key? key, required this.initialRatio, required this.enabled, required this.onRatioChanged}) : super(key: key);

  @override
  State<MyActivitySlider> createState() => _MyActivitySliderState();
}

class _MyActivitySliderState extends State<MyActivitySlider> {
  late double _ratio;

  @override
  void initState() {
    super.initState();
    _ratio = widget.initialRatio;
  }

  Map<int, String> activityLevels = {
    1: 'Sedentary ',
    2: 'Lightly active ',
    3: 'Moderately active ',
    4: 'Very active ',
    5: 'Super active '
  };

  Map<int, String> activityShortDescriptions = {
    1: 'you have desk jobs and little to no physical activity.',
    2: 'you engage in light exercise or sports 1-3 times a week.',
    3: 'you exercise moderately 3-5 times a week.',
    4: 'you engage in hard exercise 6-7 times a week.',
    5: 'you have hard physical jobs or very intense exercise routines.'
  };

  int _getSliderValue(double ratio) {
    if (ratio == 1.2) return 1;
    if (ratio == 1.375) return 2;
    if (ratio == 1.55) return 3;
    if (ratio == 1.725) return 4;
    if (ratio == 1.9) return 5;
    return 1; // default to sedentary if ratio is not matched
  }

  double _getRatioValue(int sliderValue) {
    if (sliderValue == 1) return 1.2;
    if (sliderValue == 2) return 1.375;
    if (sliderValue == 3) return 1.55;
    if (sliderValue == 4) return 1.725;
    if (sliderValue == 5) return 1.9;
    return 1.2; // default to sedentary if sliderValue is not matched
  }

  @override
  Widget build(BuildContext context) {
    int sliderValue = _getSliderValue(_ratio);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Opacity(
        opacity: widget.enabled? 1 : 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Slider(
              value: sliderValue.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: activityLevels[sliderValue],
              onChanged:widget.enabled?  (value) {
                setState(() {
                  sliderValue = value.toInt();
                  _ratio = _getRatioValue(sliderValue);
                  widget.onRatioChanged(_ratio);
                });
              } : (value){},
              
              inactiveColor: Theme.of(context).colorScheme.surface,
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                activityShortDescriptions[sliderValue]!,
                textAlign:TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 13,
        
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
