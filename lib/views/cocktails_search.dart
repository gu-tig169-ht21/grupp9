import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class CocktailSearch extends SearchDelegate<String> {
  var cocktails = [];
  var recentSearch = [];
  CocktailSearch(this.cocktails);

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, '');
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var favourites = [];
    Future<Cocktails> fetchCocktail(String cocktail) async {
      var res = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=' +
              cocktail));
      // ignore: unnecessary_null_comparison
      if (res.body != null && res.body != '') {
        var drinks = jsonDecode(res.body)['drinks'][0];

        return Cocktails.fromJson(drinks);
      } else {
        return Cocktails.empty();
      }
    }

    fetchFavourites() {
      favourites =
          Provider.of<FavouritesProvider>(context, listen: false).favourites;
    }

    bool checkFavourite(String drink) {
      return favourites.any((f) => f.title == drink);
    }

    fetchFavourites();
    return FutureBuilder<Cocktails>(
      future: fetchCocktail(query),
      builder: (BuildContext context, AsyncSnapshot<Cocktails> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Scaffold(
                extendBody: true,
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          Text(
                              (snapshot.data == null)
                                  ? ""
                                  : snapshot.data!.strIngredient1,
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              (snapshot.data == null)
                                  ? ""
                                  : snapshot.data!.strInstructions,
                              style: const TextStyle(color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                                height: 300,
                                child: Image.network((snapshot.data == null)
                                    ? "https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
                                    : snapshot.data!.strDrinkThumb)),
                          ),
                          FavoriteButton(
                            iconSize: 30,
                            isFavorite: checkFavourite(snapshot.data!.strDrink),
                            valueChanged: (_isFavorite) {
                              if (_isFavorite == true) {
                                Provider.of<FavouritesProvider>(context,
                                        listen: false)
                                    .addFavourite(
                                        snapshot.data!.strDrink, false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${snapshot.data!.strDrink} har lagts till i Favoriter! :)))'),
                                  ),
                                );
                                fetchFavourites();
                              } else {
                                var f = favourites.firstWhere((element) =>
                                    element.title == snapshot.data!.strDrink);
                                Provider.of<FavouritesProvider>(context,
                                        listen: false)
                                    .removeFavourite(f);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${snapshot.data!.strDrink} har tagits bort från Favoriter! :((('),
                                  ),
                                );
                                fetchFavourites();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentSearch
        : cocktails.where((cocktail) {
            final cocktailLower = cocktail.strDrink.toLowerCase();
            final queryLower = query.toLowerCase();
            return cocktailLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          onTap: () {
            query = suggestion.strDrink;
            showResults(context);
          },
          title: Text(
            suggestion.strDrink,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
