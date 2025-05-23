import 'package:flutter/material.dart';
import '../services/inventory_service.dart';
import '../services/meal_ai_service.dart';

class MealPlanScreen extends StatefulWidget {
  final String goal;
  MealPlanScreen({required this.goal});

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  String aiResponse = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    generatePlan();
  }

  Future<void> generatePlan() async {
    final items = await InventoryService.getItems();
    final ingredientList = items.map((i) => i.name).toList();

    try {
      final result = await MealAIService.getMealPlan(ingredientList, widget.goal);
      setState(() {
        aiResponse = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        aiResponse = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Plan')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(child: Text(aiResponse)),
            ),
    );
  }
}
