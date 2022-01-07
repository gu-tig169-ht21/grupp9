import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'dart:convert';
import '/models/favourites.dart';
import 'api_response.dart';

class CocktailsProvider extends ChangeNotifier {
  List<FavouritesModel> _favourites = [];
  final List<Cocktails> _rcocktails = [];
  final List<Cocktails> _cocktails = [];
  final List<Cocktails> _ncocktails = [];
  var ingredients = [];

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
    var res = await ApiResponse().fetchIngredients();
    ingredients = jsonDecode(res)["drinks"];
    notifyListeners();
  }

  // void getCocktails() async {
  //   String response = await ApiResponse().fetchCocktails();
  //   var json = jsonDecode(response);

  //   _cocktails = json.map<Cocktails>((data) {
  //     return Cocktails.fromJson(data);
  //   }).toList();
  //   notifyListeners();
  // }

  // void getNonAlcCocktails() async {
  //   String response = await ApiResponse().fetchNonAlcCocktails();
  //   var json = jsonDecode(res);

  //   _ncocktails = json.map<Cocktails>((data) {
  //     return Cocktails.fromJson(data);
  //   }).toList();
  //   notifyListeners();
  // }
}
