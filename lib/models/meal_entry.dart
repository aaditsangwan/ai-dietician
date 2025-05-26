class MealEntry {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  MealEntry({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
      };

  factory MealEntry.fromJson(Map<String, dynamic> json) => MealEntry(
        name: json['name'],
        calories: json['calories'],
        protein: json['protein'],
        carbs: json['carbs'],
        fat: json['fat'],
      );
}
