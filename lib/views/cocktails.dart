import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:my_first_app/views/details.dart';
import 'package:provider/provider.dart';
import 'cocktails_search.dart';

class DrinksView extends StatefulWidget {
  const DrinksView({Key? key}) : super(key: key);
  @override
  _DrinksViewState createState() => _DrinksViewState();
}

class _DrinksViewState extends State<DrinksView> {
  var url =
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic';
  var cocktails = [];
  var favourites = [];
  @override
  void initState() {
    super.initState();

    fetchCocktails();
    fetchFavourites();
  }

  fetchFavourites() {
    favourites =
        Provider.of<FavouritesProvider>(context, listen: false).favourites;
  }

  fetchCocktails() async {
    var res = await http.get(Uri.parse(url));
    var drinks = jsonDecode(res.body)['drinks'];

    cocktails = drinks.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();

    setState(() {});
  }

  bool checkFavourite(String drink) {
    return favourites.any((f) => f.title == drink);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/2.jpg"),
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
                      'Drinks & Cocktails',
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
                              delegate: CocktailSearch(cocktails));
                        },
                        icon: const Icon(Icons.search)),
                  ],
                ),
                body: SizedBox(
                  height: 590,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView.builder(
                      itemCount: cocktails.length,
                      itemBuilder: (context, index) {
                        var cocktail = cocktails[index];
                        return Card(
                          margin: const EdgeInsets.all(0.7),
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
                            trailing: FavoriteButton(
                              iconSize: 30,
                              isFavorite: checkFavourite(cocktail.strDrink),
                              valueChanged: (_isFavorite) {
                                if (_isFavorite == true) {
                                  Provider.of<FavouritesProvider>(context,
                                          listen: false)
                                      .addFavourite(cocktail.strDrink, false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${cocktail.strDrink} har lagts till i Favoriter!'),
                                    ),
                                  );
                                  fetchFavourites();
                                } else {
                                  var f = favourites.firstWhere((element) =>
                                      element.title == cocktail.strDrink);
                                  Provider.of<FavouritesProvider>(context,
                                          listen: false)
                                      .removeFavourite(f);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${cocktail.strDrink} har tagits bort från Favoriter! :((('),
                                    ),
                                  );
                                  fetchFavourites();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
