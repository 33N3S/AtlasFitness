import 'package:flutter/material.dart';

class BigTitle extends StatelessWidget {

  final String text;

const BigTitle({ Key? key, required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(text,
        style:TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary
        )),
      ),
    );
  }
}