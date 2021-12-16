import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/providers/ingredients_provider.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class IngrediensVy extends StatefulWidget {
  @override
  _IngrediensVyState createState() => _IngrediensVyState();
}

class _IngrediensVyState extends State<IngrediensVy> {
  var api = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list";
  var res;
  var ingredients = [];
  var cocktails = [];
  final _controller = TextEditingController();
  bool check = false;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    res = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'));
    ingredients = jsonDecode(res.body)["drinks"];
    setState(() {});
  }

  fetchCockails(String ingredient) async {
    res = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
            ingredient));
    var drinks = jsonDecode(res.body)["drinks"];
    cocktails = drinks.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: const Center(
                        child: Text(
                          "Ingredienser",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      backgroundColor: Colors.black12.withOpacity(0.65),
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: IngredientSearch(ingredients));
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    body: SizedBox(
                      height: 590,
                      child: Center(
                        child: ListView.builder(
                            itemCount: ingredients.length,
                            itemBuilder: (context, index) {
                              var ingredient = ingredients[index];
                              return SizedBox(
                                height: 60,
                                child: Card(
                                  color: Colors.black12.withOpacity(0.4),
                                  child: ListTile(
                                      leading: Text(
                                          "${ingredient["strIngredient1"]}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white)),
                                      onTap: () {
                                        showSearch(
                                            context: context,
                                            delegate:
                                                IngredientSearch(ingredients),
                                            query:
                                                ingredient['strIngredient1']);
                                      }),
                                ),
                              );
                            }),
                      ),
                    )),
              )))
    ]);
  }
}

class IngredientSearch extends SearchDelegate<String> {
  var ingredients = [];
  var recentSearch = [];
  IngredientSearch(this.ingredients);

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var res;
    var cocktails = [];

    Future<List> fetchCocktails(String ingredient) async {
      res = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
              ingredient));
      if (res.body != null && res.body != '') {
        var drinks = jsonDecode(res.body)["drinks"];
        return drinks.map<Cocktails>((data) {
          return Cocktails.fromJson(data);
        }).toList();
      } else {
        return cocktails;
      }
    }

    return FutureBuilder<List>(
      future: fetchCocktails(query), // async work
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
                      image: AssetImage("assets/3.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                          child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SizedBox(
                                height: 590,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var cocktail = snapshot.data![index];
                                      return Card(
                                        margin: const EdgeInsets.all(0.7),
                                        color: Colors.black12.withOpacity(0.4),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                      cocktail: cocktail)),
                                            );
                                          },
                                          leading: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.network(
                                                  cocktail.strDrinkThumb)),
                                          title: Text("${cocktail.strDrink}",
                                              style: const TextStyle(
                                                  fontSize: 21,
                                                  color: Colors.white)),
                                        ),
                                      );
                                    }),
                              )))));
            }
        }
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
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
              onTap: () {
                query = suggestion['strIngredient1'];
                showResults(context);
              },
              title: Text(suggestion['strIngredient1'],
                  style: const TextStyle(color: Colors.black)));
        });
  }
}
