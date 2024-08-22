import 'package:flutter/material.dart';

class MyTimelineCard extends StatelessWidget {
const MyTimelineCard({ Key? key, required this.content }) : super(key: key);

  final Widget content;
  
  @override
  Widget build(BuildContext context){
    return Container(
      height: 350,
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10)
      ),
      child: content
    );
  }
}