import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileMacroScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  ProfileMacroScreen({required this.data});

  @override
  _ProfileMacroScreenState createState() => _ProfileMacroScreenState();
}

class _ProfileMacroScreenState extends State<ProfileMacroScreen> {
  late double proteinPct;
  late double carbPct;
  late double fatPct;

  late int calories;

  @override
  void initState() {
    super.initState();
    calories = widget.data['calories'];

    final goal = widget.data['goal'];
    if (goal == 'cut_fast' || goal == 'cut') {
      proteinPct = 0.40;
      carbPct = 0.35;
      fatPct = 0.25;
    } else if (goal == 'recomp') {
      proteinPct = 0.35;
      carbPct = 0.40;
      fatPct = 0.25;
    } else if (goal == 'bulk') {
      proteinPct = 0.30;
      carbPct = 0.50;
      fatPct = 0.20;
    } else {
      proteinPct = 0.30;
      carbPct = 0.45;
      fatPct = 0.25;
    }
  }

  @override
  Widget build(BuildContext context) {
    int proteinGrams = ((proteinPct * calories) / 4).round();
    int carbGrams = ((carbPct * calories) / 4).round();
    int fatGrams = ((fatPct * calories) / 9).round();

    return Scaffold(
      appBar: AppBar(title: Text('Macros & Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Your Daily Calorie Goal: $calories kcal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Macro Split (%)"),
            SliderSetting(label: "Protein", value: proteinPct, onChanged: (val) {
              setState(() => proteinPct = val);
            }),
            SliderSetting(label: "Carbs", value: carbPct, onChanged: (val) {
              setState(() => carbPct = val);
            }),
            SliderSetting(label: "Fat", value: fatPct, onChanged: (val) {
              setState(() => fatPct = val);
            }),
            SizedBox(height: 24),
            Text("Daily Targets:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Protein: $proteinGrams g"),
            Text("Carbs: $carbGrams g"),
            Text("Fat: $fatGrams g"),
            SizedBox(height: 32),
            ElevatedButton(
              child: Text("Save Profile"),
              onPressed: () async {
                final profile = UserProfile(
                  sex: widget.data['sex'],
                  age: widget.data['age'],
                  heightFeet: widget.data['heightFeet'],
                  heightInches: widget.data['heightInches'],
                  weightLbs: widget.data['weightLbs'],
                  activityFactor: widget.data['activityFactor'],
                  goal: widget.data['goal'],
                  calories: calories,
                  proteinPct: proteinPct,
                  carbPct: carbPct,
                  fatPct: fatPct,
                  proteinGrams: proteinGrams,
                  carbGrams: carbGrams,
                  fatGrams: fatGrams,
                );

                await ProfileService.saveProfile(profile);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SliderSetting extends StatelessWidget {
  final String label;
  final double value;
  final Function(double) onChanged;

  const SliderSetting({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$label: ${(value * 100).round()}%"),
        Slider(
          value: value,
          min: 0.05,
          max: 0.80,
          divisions: 15,
          label: "${(value * 100).round()}%",
          onChanged: onChanged,
        ),
      ],
    );
  }
}
