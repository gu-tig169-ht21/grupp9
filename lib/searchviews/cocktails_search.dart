import 'dart:convert';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/views/details.dart';
import '../models/cocktails.dart';

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
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
          )),
      appBarTheme: const AppBarTheme(color: Colors.black12, elevation: 0),
      scaffoldBackgroundColor: Colors.transparent,
    );
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
    http.Response res;
    var cocktails = [];

    Future<List> fetchCocktails(String drink) async {
      res = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=' + drink));
      if (res.body != '') {
        var drinks = jsonDecode(res.body)["drinks"];
        return drinks.map<Cocktails>((data) {
          return Cocktails.fromJson(data);
        }).toList();
      } else {
        return cocktails;
      }
    }

    return FutureBuilder<List>(
      future: fetchCocktails(query),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
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
                  });
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(cocktail: suggestion.strDrink)));
                        },
                        title: Text(
                          suggestion.strDrink,
                          style: const TextStyle(fontSize: 21),
                        )),
                  );
                })));
  }
}
