import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyDailyTipContainer extends StatefulWidget {
  const MyDailyTipContainer({ Key? key }) : super(key: key);

  @override
  _MyDailyTipContainerState createState() => _MyDailyTipContainerState();
}

class _MyDailyTipContainerState extends State<MyDailyTipContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      alignment: Alignment.center,
      child: const Text("Always remember to stay hydrated ❤",
      style: TextStyle(
        fontSize: 15,
      ),),
    );
  }
}