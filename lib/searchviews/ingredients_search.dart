import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:my_first_app/views/details.dart';
import 'package:provider/provider.dart';

class IngredientSearch extends SearchDelegate<String> {
  var ingredients = [];
  var recentSearch = [];
  IngredientSearch(this.ingredients);

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
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.black12,
        ),
        scaffoldBackgroundColor: Colors.black12,
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
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentSearch
        : ingredients.where((ingredient) {
            final ingredientLower = ingredient['strIngredient1'].toLowerCase();
            final queryLower = query.toLowerCase();
            return ingredientLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/3.jpg"),
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
                    query = suggestion['strIngredient1'];
                    showResults(context);
                  },
                  title: Text(
                    suggestion['strIngredient1'],
                    style: const TextStyle(fontSize: 21),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '') {
      return FutureBuilder<List>(
        future: Provider.of<CocktailsProvider>(context, listen: false)
            .getIngredientsSearch(query),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading....');
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/3.jpg"), fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                        child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 40,
                                          color: Colors.black.withOpacity(0.5),
                                          child: Center(
                                              child: Text(
                                            'Drinks with $query',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          )))),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var cocktail = snapshot.data![index];
                                        return Card(
                                          color:
                                              Colors.black12.withOpacity(0.4),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                            cocktail: cocktail
                                                                .strDrink)),
                                              );
                                            },
                                            leading: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: Image.network(
                                                    cocktail.strDrinkThumb)),
                                            title: Text("${cocktail.strDrink}",
                                                style: const TextStyle(
                                                    fontSize: 21)),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ))));
              }
          }
        },
      );
    } else {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/3.jpg"), fit: BoxFit.cover),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: const Scaffold(backgroundColor: Colors.transparent)));
    }
  }
}
