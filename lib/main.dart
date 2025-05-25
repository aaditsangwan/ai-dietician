import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_activity_screen.dart';
import 'screens/profile_macro_screen.dart';
import 'screens/profile_summary_screen.dart'; // NEW

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Dietitian',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/profile': (_) => ProfileScreen(),
        '/profile/activity': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ProfileActivityScreen(
            sex: args['sex'],
            age: args['age'],
            heightFeet: args['heightFeet'],
            heightInches: args['heightInches'],
            weightLbs: args['weightLbs'],
          );
        },
        '/profile/macros': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ProfileMacroScreen(data: args);
        },
        '/profile/summary': (_) => ProfileSummaryScreen(), // NEW
      },
    );
  }
}
