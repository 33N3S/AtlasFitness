import 'package:flutter/material.dart';

class HomePageTitle extends StatelessWidget {
  final String text;
const HomePageTitle({ Key? key, required this.text }) : super(key: key);



  @override
  Widget build(BuildContext context){
    return Padding(
              padding: const EdgeInsets.only(left:20),
              child: Row(
                children: [
                  Text(text,
                  style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 40,
            fontWeight: FontWeight.w200),
            )
                ],
              ),
            );
  }
}