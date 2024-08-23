import 'package:atlas_fitness/pages/home_page.dart';
import 'package:atlas_fitness/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.primary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 2.0,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(CupertinoIcons.house_fill, size: 30, color: Theme.of(context).colorScheme.surface), onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomePage())); }),
            IconButton(icon: Icon(CupertinoIcons.person_fill, size: 30, color: Theme.of(context).colorScheme.surface), onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>const ProfilePage())); }),
            const SizedBox(width: 40), // Space for the FAB
            Icon(CupertinoIcons.time_solid, size: 30, color: Theme.of(context).colorScheme.surface),
            IconButton(icon: Icon(CupertinoIcons.collections_solid, size: 30, color: Theme.of(context).colorScheme.surface), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
