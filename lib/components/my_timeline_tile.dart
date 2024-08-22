import 'package:atlas_fitness/components/my_timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
const MyTimelineTile({ Key? key,
  required this.isFirst,
  required this.isLast,
  required this.isPast,
  required this.icon, 
  required this.content, 
  required this.isDone }) : super(key: key);

  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isDone;
  final IconData icon;
  final Widget content;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 370,
        child: Opacity(
          opacity: isPast? 0.2 : 1,
          child: TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            beforeLineStyle: LineStyle(color: Theme.of(context).colorScheme.primary),
            indicatorStyle: IndicatorStyle(
              width: 40,
              color: Theme.of(context).colorScheme.primary,
              iconStyle: IconStyle(
                iconData:isDone? Icons.done_rounded : icon,
                color: Theme.of(context).colorScheme.surface)
            
              ),
            endChild: MyTimelineCard(content:content),
          ),
        ),
      ),
    );
  }
}