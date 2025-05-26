import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'pantry_screen.dart';
import 'meal_plan_screen.dart';

class HomeScreen extends StatelessWidget {
  final String fitnessGoal = 'gain muscle'; // fallback

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Dietitian'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile/summary');
                },
                icon: Icon(Icons.person),
                label: Text('View Profile'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ScanScreen()),
                  );
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Scan a Grocery Item'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PantryScreen()),
                  );
                },
                icon: Icon(Icons.kitchen),
                label: Text('View Pantry'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MealPlanScreen(goal: fitnessGoal)),
                  );
                },
                icon: Icon(Icons.fastfood),
                label: Text('Generate Meal Plan'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/tracker');
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Daily Meal Tracker'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}