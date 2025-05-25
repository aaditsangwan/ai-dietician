import 'package:flutter/material.dart';

class ProfileActivityScreen extends StatefulWidget {
  final String sex;
  final int age;
  final int heightFeet;
  final int heightInches;
  final int weightLbs;

  ProfileActivityScreen({
    required this.sex,
    required this.age,
    required this.heightFeet,
    required this.heightInches,
    required this.weightLbs,
  });

  @override
  _ProfileActivityScreenState createState() => _ProfileActivityScreenState();
}

class _ProfileActivityScreenState extends State<ProfileActivityScreen> {
  double activityFactor = 1.2;
  String fitnessGoal = 'maintain';

  final activityOptions = {
    'Sedentary (little or no exercise)': 1.2,
    'Lightly active (1–3 days/week)': 1.375,
    'Moderately active (3–5 days/week)': 1.55,
    'Very active (6–7 days/week)': 1.725,
    'Super active (twice/day)': 1.9,
  };

  final goalAdjustments = {
    'cut_fast': -1000,
    'cut': -500,
    'maintain': 0,
    'recomp': 250,
    'bulk': 500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Activity & Goal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Activity Level", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: activityOptions.keys.firstWhere((k) => activityOptions[k] == activityFactor),
              items: activityOptions.keys.map((label) {
                return DropdownMenuItem(
                  child: Text(label),
                  value: label,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  activityFactor = activityOptions[val]!;
                });
              },
            ),
            SizedBox(height: 24),
            Text("Fitness Goal", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: fitnessGoal,
              items: {
                'cut_fast': 'Cut (2 lbs/week)',
                'cut': 'Cut (1 lb/week)',
                'maintain': 'Maintain weight',
                'recomp': 'Recomp (slow muscle gain)',
                'bulk': 'Bulk (1–2 lbs/week)',
              }.entries.map((entry) {
                return DropdownMenuItem(
                  child: Text(entry.value),
                  value: entry.key,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  fitnessGoal = val!;
                });
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              child: Text('Next: Macros & Summary'),
              onPressed: () {
                final double heightCm = (widget.heightFeet * 30.48) + (widget.heightInches * 2.54);
                final double weightKg = widget.weightLbs / 2.205;

                double bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * widget.age);
                bmr += (widget.sex == 'male') ? 5 : -161;

                double tdee = bmr * activityFactor;
                double adjustedCalories = tdee + goalAdjustments[fitnessGoal]!;

                Navigator.pushNamed(
                  context,
                  '/profile/macros',
                  arguments: {
                    ...widgetToMap(),
                    'activityFactor': activityFactor,
                    'goal': fitnessGoal,
                    'calories': adjustedCalories.round(),
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> widgetToMap() {
    return {
      'sex': widget.sex,
      'age': widget.age,
      'heightFeet': widget.heightFeet,
      'heightInches': widget.heightInches,
      'weightLbs': widget.weightLbs,
    };
  }
}
