import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'dart:convert';
import '/models/favourites.dart';
import 'api_response.dart';

class CocktailsProvider extends ChangeNotifier {
  List<FavouritesModel> _favourites = [];
  final List<Cocktails> _rcocktails = [];
  List<Cocktails> _cocktails = [];
  List<Cocktails> _ncocktails = [];
  List _ingredients = [];
  final Cocktails _cocktail = Cocktails.empty();
  String _quote = '';

  String get quote => _quote;
  Cocktails get cocktail => _cocktail;
  List get ingredients => _ingredients;
  List<FavouritesModel> get favourites => _favourites;
  List<Cocktails> get rlist => _rcocktails;
  List<Cocktails> get list => _cocktails;
  List<Cocktails> get nlist => _ncocktails;

  void getFavourites() async {
    String response = await ApiResponse().fetchFavourites();
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();
    notifyListeners();
  }

  void addFavourite(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ApiResponse().addFavourite(body);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void removeFavourite(FavouritesModel item) async {
    String response = await ApiResponse().removeFavourite(item.id);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void getRandomCocktail() async {
    String response = await ApiResponse().fetchRandomCocktail();
    Map<String, dynamic> json = jsonDecode(response);
    var cocktail = Cocktails.fromJson(json["drinks"][0]);
    _rcocktails.add(cocktail);
    notifyListeners();
  }

  void getIngredients() async {
    var response = await ApiResponse().fetchIngredients();
    _ingredients = jsonDecode(response)['drinks'];
    notifyListeners();
  }

  void getCocktails() async {
    String response = await ApiResponse().fetchCocktails();
    var json = jsonDecode(response)['drinks'];

    _cocktails = json.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();
    notifyListeners();
  }

  void getNonAlcCocktails() async {
    String response = await ApiResponse().fetchNonAlcCocktails();
    var json = jsonDecode(response)['drinks'];

    _ncocktails = json.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();
    notifyListeners();
  }

  Future<Cocktails> getOneCocktail(String cocktail) async {
    var res = await ApiResponse().fetchOneCocktail(cocktail);
    var drinks = jsonDecode(res)['drinks'][0];
    notifyListeners();
    return Cocktails.fromJson(drinks);
  }

  void getRandomQuote() {
    final list = [
      '“Different cocktails for different Saturday nights.” ― Drew Barrymore',
      '“No amount of physical contact could match the healing powers of a well made cocktail.” — David Sedaris',
      '"Cenosillicaphobia (noun): the fear of an empty glass"',
      '"When life gives you lemons, make whiskey sours"',
      '“Shaken, not stirred.” —James Bond',
    ];
    _quote = list[Random().nextInt(4)];
  }

  Future<List> getCocktailsSearch(String cocktail) async {
    var res = await ApiResponse().fetchCocktailsSearch(cocktail);
    var drinks = jsonDecode(res)["drinks"];
    if (drinks != null) {
      return drinks.map<Cocktails>((data) {
        return Cocktails.fromJson(data);
      }).toList();
    } else {
      return [];
    }
  }

  Future<List> getIngredientsSearch(String ingredients) async {
    var res = await ApiResponse().fetchIngredientsSearch(ingredients);
    if (res != '') {
      var drinks = jsonDecode(res)["drinks"];
      return drinks.map<Cocktails>((data) {
        return Cocktails.fromJson(data);
      }).toList();
    } else {
      return [];
    }
  }
}
