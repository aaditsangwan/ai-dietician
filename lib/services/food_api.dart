import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodInfo {
  final String name;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  FoodInfo({required this.name, required this.calories, required this.protein, required this.fat, required this.carbs});
}

class FoodAPI {
  static Future<FoodInfo?> fetchFoodInfo(String barcode) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 1) {
        final product = data['product'];
        final nutriments = product['nutriments'] ?? {};

        return FoodInfo(
          name: product['product_name'] ?? 'Unknown',
          calories: (nutriments['energy-kcal_100g'] ?? 0).toDouble(),
          protein: (nutriments['proteins_100g'] ?? 0).toDouble(),
          fat: (nutriments['fat_100g'] ?? 0).toDouble(),
          carbs: (nutriments['carbohydrates_100g'] ?? 0).toDouble(),
        );
      }
    }
    return null;
  }
}
