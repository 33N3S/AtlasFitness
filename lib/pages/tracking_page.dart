import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_daily_tip_container.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_quick_actions_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatelessWidget {
const TrackingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      floatingActionButton: MyFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
            children: [
            const SizedBox(height: 20),
            const HomePageTitle(text: "Tip of the day"),
            const MyDailyTipContainer(),
            const SizedBox(height: 20),
            const HomePageTitle(text: "Quick Actions"),
            QuickActionsTable(),  
          ],
        ),
      )

    );
  }
}