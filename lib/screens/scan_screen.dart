import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../services/food_api.dart';
import '../models/food_item.dart';
import '../services/inventory_service.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _barcode = 'Not scanned yet';

  Future<void> scanBarcode() async {
  String scannedCode = await FlutterBarcodeScanner.scanBarcode(
    '#ff6666', 'Cancel', true, ScanMode.BARCODE);

  if (!mounted || scannedCode == '-1') return;

  setState(() {
    _barcode = scannedCode;
  });

  final food = await FoodAPI.fetchFoodInfo(scannedCode);

  if (food != null) {
    final foodItem = FoodItem(
      name: food.name,
      calories: food.calories,
      protein: food.protein,
      fat: food.fat,
      carbs: food.carbs,
      barcode: _barcode,
    );

    await InventoryService.addItem(foodItem);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(food.name),
        content: Text(
          'Added to pantry!\n\n'
          'Calories: ${food.calories} kcal\n'
          'Protein: ${food.protein}g\n'
          'Fat: ${food.fat}g\n'
          'Carbs: ${food.carbs}g',
        ),
        actions: [TextButton(child: Text('OK'), onPressed: () => Navigator.pop(context))],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Product not found'),
        content: Text('No data available for barcode $scannedCode.'),
        actions: [TextButton(child: Text('OK'), onPressed: () => Navigator.pop(context))],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Item')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scanned: $_barcode'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
