import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/daily_log.dart';
import '../services/daily_log_service.dart';
import '../models/meal_entry.dart';

class MealTrackerScreen extends StatefulWidget {
  @override
  _MealTrackerScreenState createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {
  late String today;
  DailyLog? log;

  @override
  void initState() {
    super.initState();
    today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    loadLog();
  }

  Future<void> loadLog() async {
    final loaded = await DailyLogService.loadLog(today);
    setState(() => log = loaded);
  }

  void _addEntry(String mealType) async {
    final entry = await showDialog<MealEntry>(
      context: context,
      builder: (_) => _AddEntryDialog(mealType: mealType),
    );

    if (entry != null) {
      setState(() {
        log!.meals[mealType]!.add(entry);
      });
      await DailyLogService.saveLog(log!);
    }
  }

  Widget _buildMealSection(String title, List<MealEntry> entries) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ...entries.map((e) => ListTile(
                title: Text(e.name),
                subtitle: Text(
                    '${e.calories} kcal | ${e.protein}g P | ${e.carbs}g C | ${e.fat}g F'),
              )),
          TextButton.icon(
            onPressed: () => _addEntry(title.toLowerCase()),
            icon: Icon(Icons.add),
            label: Text('Add Food'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (log == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Meal Tracker")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Meal Tracker – Today")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Total for Today", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Calories: ${log!.totalCalories.toStringAsFixed(0)} kcal"),
            Text("Protein: ${log!.totalProtein.toStringAsFixed(0)} g"),
            Text("Carbs: ${log!.totalCarbs.toStringAsFixed(0)} g"),
            Text("Fat: ${log!.totalFat.toStringAsFixed(0)} g"),
            SizedBox(height: 20),
            _buildMealSection("Breakfast", log!.meals["breakfast"]!),
            _buildMealSection("Lunch", log!.meals["lunch"]!),
            _buildMealSection("Dinner", log!.meals["dinner"]!),
            _buildMealSection("Snacks", log!.meals["snacks"]!),
          ],
        ),
      ),
    );
  }
}

class _AddEntryDialog extends StatefulWidget {
  final String mealType;
  _AddEntryDialog({required this.mealType});

  @override
  State<_AddEntryDialog> createState() => _AddEntryDialogState();
}

class _AddEntryDialogState extends State<_AddEntryDialog> {
  String name = '';
  double calories = 0, protein = 0, carbs = 0, fat = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add to ${widget.mealType}'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Food name'), onChanged: (val) => name = val),
            TextField(decoration: InputDecoration(labelText: 'Calories'), keyboardType: TextInputType.number, onChanged: (val) => calories = double.tryParse(val) ?? 0),
            TextField(decoration: InputDecoration(labelText: 'Protein (g)'), keyboardType: TextInputType.number, onChanged: (val) => protein = double.tryParse(val) ?? 0),
            TextField(decoration: InputDecoration(labelText: 'Carbs (g)'), keyboardType: TextInputType.number, onChanged: (val) => carbs = double.tryParse(val) ?? 0),
            TextField(decoration: InputDecoration(labelText: 'Fat (g)'), keyboardType: TextInputType.number, onChanged: (val) => fat = double.tryParse(val) ?? 0),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              MealEntry(name: name, calories: calories, protein: protein, carbs: carbs, fat: fat),
            );
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}