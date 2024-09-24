import 'package:atlas_fitness/backend/controllers/person_controller.dart';
import 'package:atlas_fitness/backend/model/person.dart';
import 'package:atlas_fitness/components/bottom_bar.dart';
import 'package:atlas_fitness/components/home_page_title.dart';
import 'package:atlas_fitness/components/my_fab.dart';
import 'package:atlas_fitness/components/my_line_chart.dart';
import 'package:atlas_fitness/components/weekly_intake_chart.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<Person?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getCurrentUser();
  }

  Future<Person?> _getCurrentUser() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService.getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found'));
        } else {
          var user = snapshot.data!;

          return Scaffold(
            bottomNavigationBar: const BottomBar(),
            floatingActionButton: const MyFab(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  const SizedBox(height: 30),
                  const HomePageTitle(text: "Week's Daiy Intake"),
                  Container(
                  clipBehavior: Clip.antiAlias,
                  height: 370, 
                  margin: const EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DailyIntakeBarChart(user: user),
                ),

                const HomePageTitle(text: "Burned Calories"),

                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 280, 
                  margin: const EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BurnedCaloriesLineChart(user: user),
                ),

                const SizedBox(height: 30,)

                

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
