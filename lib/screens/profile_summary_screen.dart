import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileSummaryScreen extends StatefulWidget {
  @override
  State<ProfileSummaryScreen> createState() => _ProfileSummaryScreenState();
}

class _ProfileSummaryScreenState extends State<ProfileSummaryScreen> {
  UserProfile? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final loaded = await ProfileService.getProfile();
    setState(() {
      profile = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Profile')),
      body: profile == null
          ? Center(child: Text('No profile found.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text("Sex: ${profile!.sex}"),
                  Text("Age: ${profile!.age}"),
                  Text("Height: ${profile!.heightFeet}' ${profile!.heightInches}\""),
                  Text("Weight: ${profile!.weightLbs} lbs"),
                  SizedBox(height: 12),
                  Text("Activity Factor: ${profile!.activityFactor}"),
                  Text("Goal: ${profile!.goal}"),
                  SizedBox(height: 12),
                  Text("Calories per day: ${profile!.calories} kcal", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Protein: ${profile!.proteinGrams}g"),
                  Text("Carbs: ${profile!.carbGrams}g"),
                  Text("Fat: ${profile!.fatGrams}g"),
                  SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }
}
