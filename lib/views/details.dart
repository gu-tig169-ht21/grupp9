import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
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
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';
  final String cocktail;
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
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FavoriteButton(
                      iconSize: 30,
                      isFavorite: checkFavourite(cocktail),
                      valueChanged: (_isFavorite) {
                        fetchFavourites();
                        if (_isFavorite == true) {
                          Provider.of<FavouritesProvider>(context,
                                  listen: false)
                              .addFavourite(cocktail, false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('$cocktail is added to Favourites'),
                          ));
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
                        }
                      }),
                )
              ],
            ),
            extendBody: true,
            body: Scrollbar(
              isAlwaysShown: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              child: Image.network((_cocktail == null)
                                  ? "https://zelly.se/wp-content/uploads/2021/06/loading-buffering.gif"
                                  : _cocktail.strDrinkThumb)),
                        ),
                      ),
                    ),
                    (_cocktail != null)
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _cocktail.ingredientsList.length,
                            itemBuilder: (BuildContext context, index) {
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Ingredients:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 27)),
                                    ),
                                    Text(_cocktail.ingredientsList[index],
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ],
                                );
                              } else {
                                return Text(_cocktail.ingredientsList[index],
                                    style:
                                        const TextStyle(color: Colors.white));
                              }
                            })
                        : const Text('No ingredients found.',
                            style: TextStyle(color: Colors.white)),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Instructions:',
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ),
                    ),
                    Text((_cocktail == null) ? "" : _cocktail.strInstructions,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
