import 'meal_entry.dart';

class DailyLog {
  final String date; // Format: 'yyyy-MM-dd'
  final Map<String, List<MealEntry>> meals; // keys: breakfast, lunch, dinner, snacks

  DailyLog({required this.date, required this.meals});

  factory DailyLog.empty(String date) {
    return DailyLog(date: date, meals: {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
      'snacks': [],
    });
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'meals': meals.map((key, value) => MapEntry(
              key,
              value.map((entry) => entry.toJson()).toList(),
            )),
      };

  factory DailyLog.fromJson(Map<String, dynamic> json) => DailyLog(
        date: json['date'],
        meals: (json['meals'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            List<MealEntry>.from(
              (value as List).map((item) => MealEntry.fromJson(item)),
            ),
          ),
        ),
      );

  // Helper to get totals
  double get totalCalories => _sum((e) => e.calories);
  double get totalProtein => _sum((e) => e.protein);
  double get totalCarbs => _sum((e) => e.carbs);
  double get totalFat => _sum((e) => e.fat);

  double _sum(double Function(MealEntry) f) =>
      meals.values.expand((m) => m).fold(0, (sum, entry) => sum + f(entry));
}
