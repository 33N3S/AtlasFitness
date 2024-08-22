import 'package:atlas_fitness/pages/tracking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFab extends StatelessWidget {
const MyFab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Container(
      margin: EdgeInsets.only(top: 40),
        height: 75.0,  // Increase the height
        width: 75.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),  
        child: FloatingActionButton(
          onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (context)=>const TrackingPage()));
          },
          shape: CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child:  Icon(CupertinoIcons.graph_circle_fill, size: 55,color: Theme.of(context).colorScheme.surfaceContainer),  // Adjust icon size
        ),
      );
  }
}