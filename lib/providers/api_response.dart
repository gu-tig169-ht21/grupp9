import 'package:http/http.dart' as http;

class ApiResponse {
  var url1 = 'https://todoapp-api-pyq5q.ondigitalocean.app';
  var url2 = 'http://www.thecocktaildb.com/api/json/v1/1';
  var key = '3f8f8e0f-935d-4b20-b4af-aefd946a5a6f';

  Future<String> fetchFavourites() async {
    final response = await http.get(Uri.parse('$url1/todos?key=$key'));
    return response.body;
  }

  Future<String> addFavourite(Object body) async {
    final response = await http.post(Uri.parse('$url1/todos?key=$key'),
        headers: {'Content-Type': 'application/json'}, body: body);
    return response.body;
  }

  Future<String> removeFavourite(String id) async {
    final response = await http.delete(Uri.parse('$url1/todos/$id?key=$key'));
    return response.body;
  }

  Future<String> fetchRandomCocktail() async {
    final response = await http.get(Uri.parse('$url2/random.php'));
    return response.body;
  }

  Future<String> fetchIngredients() async {
    final response = await http.get(Uri.parse('$url2/list.php?i=list'));
    return response.body;
  }

  // Future<String> fetchCocktails() async {
  //   final response = await http.get(Uri.parse('$url2/filter.php?a=Alcoholic'));
  //   return response.body;
  // }

  // Future<String> fetchNonAlcCocktails() async {
  //   final response =
  //       await http.get(Uri.parse('$url2/filter.php?a=NonAlcoholic'));
  //   return response.body;
  // }
}
