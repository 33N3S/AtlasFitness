import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyEnabledButton extends StatelessWidget {

final Function()?  onTap;
final String text;
final bool enabled;
final bool waiting;

const MyEnabledButton({ Key? key,
  required this.text,
  required this.onTap, 
  required this.enabled, 
  required this.waiting
 }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        onTap: enabled? onTap : (){},
        child: Container(
          padding:const EdgeInsets.all(25),
          margin:const EdgeInsets.symmetric(horizontal: 25),
      
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
          child:Center(
            child: waiting? 
            Center(child: CircularProgressIndicator( color: Theme.of(context).colorScheme.surface,)):
            Text(
              text,
              style:TextStyle(color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: 16)
              ) 
          )    
          ),
      ),
    );
  }
}