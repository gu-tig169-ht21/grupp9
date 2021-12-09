import 'package:flutter/cupertino.dart';
import 'dart:convert';

import '/models/ingredients.dart';
import 'response_provider.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredients> _ingredients = [];
  String _filterBy = 'all';
  final String _key = /*'ebe1a990-2a5d-486d-bc99-a1c4de909bbb'*/ '';
  String get key => _key;
  List<Ingredients> get list => _ingredients;

  Future getIngredients() async {
    String response = await ResponseProvider().fetchItems(key);
    var json = jsonDecode(response);
    _ingredients = json.map<Ingredients>((data) {
      return Ingredients.fromJson(data);
    }).toList();
    notifyListeners();
  }

  String get filterBy => _filterBy;

  void addIngredient(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ResponseProvider().addItem(body, key);
    var json = jsonDecode(response);
    _ingredients = json.map<Ingredients>((data) {
      return Ingredients.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void updateIngredient(Ingredients item, bool done) async {
    Map data = {
      'id': item.id,
      'title': item.title,
      'done': done,
    };
    var body = jsonEncode(data);
    String response = await ResponseProvider().updateItem(body, item.id, key);
    var json = jsonDecode(response);
    _ingredients = json.map<Ingredients>((data) {
      return Ingredients.fromJson(data);
    }).toList();

    notifyListeners();
  }

  void removeIngredient(Ingredients item) async {
    String response = await ResponseProvider().removeItem(item.id, key);
    var json = jsonDecode(response);
    _ingredients = json.map<Ingredients>((data) {
      return Ingredients.fromJson(data);
    }).toList();

    notifyListeners();
  }

  //void updateAll(bool check) {
  //for (var a in _ingredients) {
  //a.checked = check;
  //}
  //notifyListeners();
  //}

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
