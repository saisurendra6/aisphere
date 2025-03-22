import 'dart:convert';
import 'dart:developer';

import 'package:aisphere/data/api_data.dart';
import 'package:http/http.dart' as http;

class GeminiModel {
  static Future<String> generateContent(String prompt) async {
    final response = await http.post(Uri.parse(geminiURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }));

    print("object");
    print(response.body.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log(data.toString());
      return data["candidates"][0]["content"]["parts"][0]["text"].toString();
    }
    return "";
  }
}
