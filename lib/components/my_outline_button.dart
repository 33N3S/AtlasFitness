import 'package:flutter/material.dart';

class MyOutlineButton extends StatelessWidget {

final String text;
final Function()? onTap;
final bool enabled;


const MyOutlineButton({ Key? key, required this.text,required this.onTap, required this.enabled }) : super(key: key);


  @override
  Widget build(BuildContext context){

    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: OutlinedButton(  
                  onPressed: enabled ? onTap : (){},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surface, // This sets the inside color to the current text color
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary, // This sets the text color to the border color
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
    );
  }
}