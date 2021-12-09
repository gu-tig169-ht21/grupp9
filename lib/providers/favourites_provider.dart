import 'package:flutter/cupertino.dart';
import 'dart:convert';

import '/models/favourites.dart';
import 'response_provider.dart';

class FavouritesProvider extends ChangeNotifier {
  List<Favourites> _favourites = [];
  String _filterBy = 'all';
  final String _key = /*'ebe1a990-2a5d-486d-bc99-a1c4de909bbb'*/ '';
  String get key => _key;
  List<Favourites> get list => _favourites;

  Future getFavourites() async {
    String response = await ResponseProvider().fetchItems(key);
    var json = jsonDecode(response);
    _favourites = json.map<Favourites>((data) {
      return Favourites.fromJson(data);
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
    _favourites = json.map<Favourites>((data) {
      return Favourites.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void updateFavourite(Favourites item, bool done) async {
    Map data = {
      'id': item.id,
      'title': item.title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ResponseProvider().updateItem(body, item.id, key);
    var json = jsonDecode(response);
    _favourites = json.map<Favourites>((data) {
      return Favourites.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void removeFavourite(Favourites item) async {
    String response = await ResponseProvider().removeItem(item.id, key);
    var json = jsonDecode(response);
    _favourites = json.map<Favourites>((data) {
      return Favourites.fromJson(data);
    }).toList();

    notifyListeners();
  }

  //void updateAll(bool check) {
  //for (var a in _favourites) {
  //a.checked = check;
  //}
  //notifyListeners();
  //}

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
