import 'package:flutter/material.dart';

class MyRegisterTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool enabled ;
  final bool isNumeric;

  MyRegisterTextField({ Key? key, required this.controller, required this.hintText, required this.obscureText, required this.enabled, required this.isNumeric }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color:Theme.of(context).colorScheme.surface),
        keyboardType: isNumeric? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
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
    );
  }
}