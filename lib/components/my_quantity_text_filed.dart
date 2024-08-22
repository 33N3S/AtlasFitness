import 'package:flutter/material.dart';

class MyQuantityTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool enabled ;
  final void Function(dynamic value) onChanged;

  MyQuantityTextField({ Key? key, required this.controller, required this.hintText, required this.obscureText, required this.enabled, required this.onChanged }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Flexible(
      child: Container(
        width: 90,
        child: TextField(
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color:Theme.of(context).colorScheme.inversePrimary),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color:Theme.of(context).colorScheme.tertiary
                ),
              focusedBorder: OutlineInputBorder(
                borderSide:BorderSide(color: Theme.of(context).colorScheme.tertiary) ),
            ), 
            enabled: enabled,
          ),
      ),
    );
  }
}