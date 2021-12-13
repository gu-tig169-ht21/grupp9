import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '/models/cocktails.dart';

import 'response_provider.dart';

class CocktailsProvider extends ChangeNotifier {
  List<Cocktails> _cocktails = [];

  List<Cocktails> get list => _cocktails;

  Future getRandomCocktail() async {
    String response = await ResponseProvider().fetchRandomCocktail();
    Map<String, dynamic> json = jsonDecode(response);

    var cocktail = Cocktails.fromJson(json["drinks"][0]);
    _cocktails.add(cocktail);
    notifyListeners();
  }
}
