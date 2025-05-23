import 'dart:convert';
import 'package:http/http.dart' as http;

class MealAIService {
  static Future<String> getMealPlan(List<String> ingredients, String goal) async {
    final prompt = '''
I have these ingredients: ${ingredients.join(", ")}.
My fitness goal is: $goal.

Suggest 3 meals I can make using these ingredients. You don't have to use all the ingredients and can suggest adding on 1 or 2 not included ingredients if really needed. Each meal should include:
- Name
- Short description
- Estimated calories, protein, carbs, and fat
''';

    final response = await http.post(
      Uri.parse('http://192.168.0.247:11434/api/generate'), // Replace with your actual IP
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "model": "mistral",
        "prompt": prompt,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? 'No response';
    } else {
      throw Exception('Failed to get meal plan from AI');
    }
  }
}
