import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';

class InventoryService {
  static const _key = 'inventory';

  static Future<void> addItem(FoodItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getItems();
    items.add(item);
    final encoded = jsonEncode(items.map((i) => i.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<List<FoodItem>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final decoded = jsonDecode(jsonString);
    return List<FoodItem>.from(
      decoded.map((item) => FoodItem.fromJson(item)),
    );
  }

  static Future<void> clearItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
