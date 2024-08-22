import 'package:atlas_fitness/pages/custom_meal_page.dart';
import 'package:atlas_fitness/pages/custom_workout_page.dart';
import 'package:atlas_fitness/pages/meal_log_page.dart';
import 'package:atlas_fitness/pages/workout_log_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuickActionsTable extends StatefulWidget {
  @override
  State<QuickActionsTable> createState() => _QuickActionsTableState();
}

class _QuickActionsTableState extends State<QuickActionsTable> {
  @override
  Widget build(BuildContext context) {
    // Get the primary color from the theme
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.2,
        shrinkWrap: true,
        children: [
          _buildTableCell(primaryColor, "Quick Meal Log", CupertinoIcons.time,MealLogPage()),
          _buildTableCell(primaryColor, "Quick Workout Log", CupertinoIcons.flame,const WorkoutLogPage()),
          _buildTableCell(primaryColor, "Create Custom Meal", CupertinoIcons.add,const CustomMealPage()),
          _buildTableCell(primaryColor, "Create Custom Workout", CupertinoIcons.flame_fill,const CustomWorkoutPage()),
        ],
      ),
    );
  }

  Widget _buildTableCell(Color color, String text, IconData icon, Widget nextPage) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=> nextPage)),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.surface,
              size: 50,
            ),
            const SizedBox(height: 15),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, 
                color: Theme.of(context).colorScheme.surface, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
