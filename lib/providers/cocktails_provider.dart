import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '/models/cocktails.dart';

import 'response_provider.dart';

class CocktailsProvider extends ChangeNotifier {
  final List<Cocktails> _cocktails = [];

  List<Cocktails> get list => _cocktails;
  final String _key = '3f8f8e0f-935d-4b20-b4af-aefd946a5a6f';
  String get key => _key;

  Future getRandomCocktail() async {
    String response = await ResponseProvider().fetchRandomCocktail();
    Map<String, dynamic> json = jsonDecode(response);

    var cocktail = Cocktails.fromJson(json["drinks"][0]);
    _cocktails.add(cocktail);
    notifyListeners();
  }

  void addFavourite(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    // ignore: unused_local_variable
    String response = await ResponseProvider().addItem(body, key);
  }
}
