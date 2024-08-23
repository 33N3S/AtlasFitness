import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool enabled ;
  final bool isNumeric;
  final String placeholder;

  ProfileTextField({ Key? key, required this.controller, required this.hintText, required this.obscureText, required this.enabled, required this.isNumeric, required this.placeholder }) : super(key: key);

  @override
  Widget build(BuildContext context){

    controller.text = placeholder;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color:Theme.of(context).colorScheme.inversePrimary),
        keyboardType: isNumeric? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color:Theme.of(context).colorScheme.secondary
            ),
          focusedBorder: OutlineInputBorder(
            borderSide:BorderSide(color: Theme.of(context).colorScheme.secondary) ),
        ), 
        enabled: enabled,
      ),
    );
  }
}