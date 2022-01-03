import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'dart:convert';
import '/models/favourites.dart';
import 'response_provider.dart';

class FavouritesProvider extends ChangeNotifier {
  List<FavouritesModel> _favourites = [];
  String _filterBy = 'all';
  final String _key = '3f8f8e0f-935d-4b20-b4af-aefd946a5a6f';
  String get key => _key;
  List<FavouritesModel> get favourites => _favourites;
  final List<Cocktails> _cocktails = [];

  List<Cocktails> get list => _cocktails;

  Future getFavourites() async {
    String response = await ResponseProvider().fetchItems(key);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();
    notifyListeners();
  }

  String get filterBy => _filterBy;

  void addFavourite(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ResponseProvider().addItem(body, key);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void updateFavourite(FavouritesModel item, bool done) async {
    Map data = {
      'id': item.id,
      'title': item.title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ResponseProvider().updateItem(body, item.id, key);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void removeFavourite(FavouritesModel item) async {
    String response = await ResponseProvider().removeItem(item.id, key);
    var json = jsonDecode(response);
    _favourites = json.map<FavouritesModel>((data) {
      return FavouritesModel.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }

  Future getRandomCocktail() async {
    String response = await ResponseProvider().fetchRandomCocktail();
    Map<String, dynamic> json = jsonDecode(response);

    var cocktail = Cocktails.fromJson(json["drinks"][0]);
    _cocktails.add(cocktail);
    notifyListeners();
  }
}
