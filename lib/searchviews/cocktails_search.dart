import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:my_first_app/views/details.dart';
import 'package:provider/provider.dart';

class CocktailSearch extends SearchDelegate<String> {
  var cocktails = [];
  var recentSearch = [];
  CocktailSearch(this.cocktails);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                )),
        appBarTheme: const AppBarTheme(color: Colors.black12, elevation: 0),
        scaffoldBackgroundColor: Colors.transparent,
        hintColor: Colors.grey);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (!recentSearch.any((element) {
          final drinkLower = element.strDrink.trim().toLowerCase();
          final queryLower = query.trim().toLowerCase();
          return drinkLower == queryLower;
        }) &&
        query != '') {
      var newSearch = Cocktails.searchSuggestion(query);

      recentSearch.add(newSearch);
    }
    return FutureBuilder<List>(
      future: Provider.of<CocktailsProvider>(context, listen: false)
          .getCocktailsSearch(query.trim()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var cocktail = snapshot.data![index];
                      return Card(
                        color: Colors.black12.withOpacity(0.4),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(cocktail: cocktail.strDrink)),
                            );
                          },
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.network(cocktail.strDrinkThumb)),
                          title: Text("${cocktail.strDrink}",
                              style: const TextStyle(
                                  fontSize: 21, color: Colors.white)),
                        ),
                      );
                    },
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
            final cocktailLower = cocktail.strDrink.trim().toLowerCase();
            final queryLower = query.trim().toLowerCase();
            return cocktailLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return Card(
                color: Colors.black12.withOpacity(0.4),
                child: ListTile(
                  onTap: () {
                    if (!recentSearch.any((element) {
                      final drinkLower = element.strDrink.trim().toLowerCase();
                      final queryLower =
                          suggestion.strDrink.trim().toLowerCase();
                      return drinkLower == queryLower;
                    })) {
                      var newSearch =
                          Cocktails.searchSuggestion(suggestion.strDrink);

                      recentSearch.add(newSearch);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Details(cocktail: suggestion.strDrink)));
                  },
                  title: Text(
                    suggestion.strDrink,
                    style: const TextStyle(fontSize: 21),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
