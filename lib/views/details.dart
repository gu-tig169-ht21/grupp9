import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState(cocktail: cocktail);
}

class _DetailsState extends State<Details> {
  final String cocktail;
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';
  var _cocktail;
  var favourites = [];
  _DetailsState({required this.cocktail});

  @override
  void initState() {
    super.initState();

    fetchCocktail();
    fetchFavourites();
  }

  fetchCocktail() async {
    var res = await http.get(Uri.parse(url + cocktail));
    var drinks = jsonDecode(res.body)['drinks'][0];
    _cocktail = Cocktails.fromJson(drinks);

    setState(() {});
  }

  fetchFavourites() {
    favourites =
        Provider.of<FavouritesProvider>(context, listen: false).favourites;
  }

  bool checkFavourite(String drink) {
    return favourites.any((f) => f.title == drink);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.grey.withOpacity(0.15),
                title: FittedBox(
                  child: Text(
                    (cocktail),
                  ),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FavoriteButton(
                        iconSize: 30,
                        isFavorite: checkFavourite(cocktail),
                        valueChanged: (_isFavorite) {
                          if (_isFavorite == true) {
                            Provider.of<FavouritesProvider>(context,
                                    listen: false)
                                .addFavourite(cocktail, false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$cocktail is added to Favourites'),
                            ));
                            fetchFavourites();
                          } else {
                            var f = favourites.firstWhere(
                                (element) => element.title == cocktail);
                            Provider.of<FavouritesProvider>(context,
                                    listen: false)
                                .removeFavourite(f);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('$cocktail is removed from Favourites'),
                            ));
                            fetchFavourites();
                          }
                        }),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        if (_cocktail != null && _cocktail.strIngredient1 != '')
                          Text(_cocktail.strIngredient1),
                        if (_cocktail != null && _cocktail.strIngredient2 != '')
                          Text(_cocktail.strIngredient2),
                        if (_cocktail != null && _cocktail.strIngredient3 != '')
                          Text(_cocktail.strIngredient3),
                        if (_cocktail != null && _cocktail.strIngredient4 != '')
                          Text(_cocktail.strIngredient4),
                        if (_cocktail != null && _cocktail.strIngredient5 != '')
                          Text(_cocktail.strIngredient5),
                        if (_cocktail != null && _cocktail.strIngredient6 != '')
                          Text(_cocktail.strIngredient6),
                        if (_cocktail != null && _cocktail.strIngredient7 != '')
                          Text(_cocktail.strIngredient7),
                        if (_cocktail != null && _cocktail.strIngredient8 != '')
                          Text(_cocktail.strIngredient8),
                        if (_cocktail != null && _cocktail.strIngredient9 != '')
                          Text(_cocktail.strIngredient9),
                        if (_cocktail != null &&
                            _cocktail.strIngredient10 != '')
                          Text(_cocktail.strIngredient10),
                        if (_cocktail != null &&
                            _cocktail.strIngredient11 != '')
                          Text(_cocktail.strIngredient11),
                        if (_cocktail != null &&
                            _cocktail.strIngredient12 != '')
                          Text(_cocktail.strIngredient12),
                        if (_cocktail != null &&
                            _cocktail.strIngredient13 != '')
                          Text(_cocktail.strIngredient13),
                        if (_cocktail != null &&
                            _cocktail.strIngredient14 != '')
                          Text(_cocktail.strIngredient14),
                        if (_cocktail != null &&
                            _cocktail.strIngredient15 != '')
                          Text(_cocktail.strIngredient15),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                              height: 300,
                              child: Image.network((_cocktail == null)
                                  ? "https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
                                  : _cocktail.strDrinkThumb)),
                        ),
                        Text((_cocktail == null)
                            ? ""
                            : _cocktail.strInstructions),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
