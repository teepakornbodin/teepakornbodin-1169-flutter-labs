// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-11

// A Dart console program that calls IP address API and parses JSON response.
// Logic: Uses async/await to make HTTP GET request and jsonDecode to parse JSON data.
// AI-verified for correctness based on the prompt.

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchIPAddress() async {
  final response = await http.get(
    Uri.parse('https://api.ipify.org?format=json'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Your public IP address is: ${data['ip']}');
  }
}

void main() async {
  await fetchIPAddress();
}
