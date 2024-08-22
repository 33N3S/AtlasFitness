import 'package:flutter/material.dart';

void displayDialogMessage(String message,BuildContext context){
  showDialog(context: context, builder: 
  (context)=> 
    AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Center(child: Text(message)),
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
        fontWeight: FontWeight.bold,
        fontSize: 20),
      titlePadding: EdgeInsets.all(40),
    )
    );
}