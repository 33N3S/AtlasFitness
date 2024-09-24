import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyLogoutButton extends StatelessWidget {

final Function()?  onTap;
final String text;
final bool enabled;
final bool waiting;

const MyLogoutButton({ Key? key,
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
          padding:const EdgeInsets.all(15),
          margin:const EdgeInsets.symmetric(horizontal: 25),
      
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10)),
          child:Center(
            child: waiting? 
            Center(child: CircularProgressIndicator( color: Theme.of(context).colorScheme.surface,)):
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_outlined,color: Colors.red,size: 25,),
                const SizedBox(width: 10,),
                Text(
                  text,
                  style: const TextStyle(color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)
                  )
              ],
            ) 
          )    
          ),
      ),
    );
  }
}