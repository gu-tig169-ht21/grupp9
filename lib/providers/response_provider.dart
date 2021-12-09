import 'package:http/http.dart' as http;
import 'dart:convert';

class ResponseProvider {
  Future<String> fetchItems(String key) async {
    final response = await http.get(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$key'));

    return response.body;
  }

  Future<String> addItem(Object body, String key) async {
    final response = await http.post(
        Uri.parse(
            'https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$key'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    return response.body;
  }

  Future<String> updateItem(Object body, String id, String key) async {
    final response = await http.put(
        Uri.parse(
            'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=$key'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    return response.body;
  }

  Future<String> removeItem(String id, String key) async {
    final response = await http.delete(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=$key'));
    return response.body;
  }
}
