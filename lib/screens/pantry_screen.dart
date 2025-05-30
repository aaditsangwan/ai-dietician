import 'package:flutter/material.dart';
import '../services/inventory_service.dart';
import '../models/food_item.dart';
import '../widgets/food_item_card.dart';

class PantryScreen extends StatefulWidget {
  @override
  _PantryScreenState createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  List<FoodItem> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final fetched = await InventoryService.getItems();
    setState(() {
      items = fetched;
    });
  }

  Future<void> deleteItem(int index) async {
    setState(() {
      items.removeAt(index);
    });
    await InventoryService.saveItems(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Pantry')),
      body: items.isEmpty
          ? Center(child: Text('No items saved.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return FoodItemCard(
                  item: item,
                  onDelete: () => deleteItem(index),
                );
              },
            ),
    );
  }
}
