import 'package:flutter/material.dart';

class MyRegisterRadio extends StatefulWidget {
  final List<String> options;
  final String groupValue;
  final bool enabled;
  final Function(String?) onChanged;

  const MyRegisterRadio({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onChanged, 
    required this.enabled,
  }) : super(key: key);

  @override
  _MyRegisterRadioState createState() => _MyRegisterRadioState();
}

class _MyRegisterRadioState extends State<MyRegisterRadio> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled? 1 : 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.options.map((option) {
          return Row(
            children: [
              Radio<String>(
                fillColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
                value: option,
                groupValue: widget.groupValue,
                onChanged: widget.enabled? widget.onChanged : (value){},
              ),
              Text(option,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold
              ),),
            ],
          );
        }).toList(),
      ),
    );
  }
}
