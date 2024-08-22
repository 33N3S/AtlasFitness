import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {

final Function()?  onTap;
final String text;

const MyButton({ Key? key,
  required this.text,
  required this.onTap
 }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(25),
        margin:const EdgeInsets.symmetric(horizontal: 25),
    
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10)),
        child:Center(
          child:Text(
            text,
            style:TextStyle(color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold,
              fontSize: 16)
            )
        )    
        ),
    );
  }
}