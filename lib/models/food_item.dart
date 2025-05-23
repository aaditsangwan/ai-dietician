class FoodItem {
  final String name;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;
  final String barcode;

  FoodItem({
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.barcode,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'protein': protein,
    'fat': fat,
    'carbs': carbs,
    'barcode': barcode,
  };

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
    name: json['name'],
    calories: json['calories'],
    protein: json['protein'],
    fat: json['fat'],
    carbs: json['carbs'],
    barcode: json['barcode'],
  );
}
