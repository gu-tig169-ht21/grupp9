import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/searchviews/cocktails_search.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:my_first_app/views/details.dart';
import 'package:provider/provider.dart';

class CocktailsView extends StatefulWidget {
  const CocktailsView({Key? key}) : super(key: key);
  @override
  _CocktailsViewState createState() => _CocktailsViewState();
}

class _CocktailsViewState extends State<CocktailsView> {
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
        Provider.of<CocktailsProvider>(context, listen: false).favourites;
  }

  fetchCocktails() {
    cocktails = Provider.of<CocktailsProvider>(context, listen: false).list;
  }

  fetchNonAlcCocktails() {
    cocktails = Provider.of<CocktailsProvider>(context, listen: false).nlist;
  }

  bool checkFavourite(String drink) {
    return Provider.of<CocktailsProvider>(context, listen: false)
        .favourites
        .any((f) => f.title == drink);
  }

  void setFilter(String value) {
    switch (value) {
      case '1':
        fetchFavourites();
        fetchCocktails();
        break;
      case '2':
        fetchFavourites();
        fetchNonAlcCocktails();
        break;
      default:
        fetchFavourites();
        fetchCocktails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Drinks & Cocktails',
              ),
              backgroundColor: Colors.black12.withOpacity(0.85),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: CocktailSearch(cocktails));
                    },
                    icon: const Icon(Icons.search)),
                PopupMenuButton<String>(
                  color: Colors.black,
                  icon: const Icon(
                    Icons.filter_list_alt,
                    color: Colors.white,
                  ),
                  onSelected: (value) {
                    setState(() {
                      setFilter(value);
                    });
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('Alcoholic'), value: '1'),
                    const PopupMenuItem(
                        child: Text('Non-alcoholic'), value: '2'),
                  ],
                ),
              ],
            ),
            body: Scrollbar(
              isAlwaysShown: true,
              child: ListView.builder(
                  itemCount: cocktails.length,
                  itemBuilder: (context, index) {
                    var cocktail = cocktails[index];
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
                            style: const TextStyle(fontSize: 21)),
                        trailing: FavoriteButton(
                            iconSize: 30,
                            isFavorite: checkFavourite(cocktail.strDrink),
                            valueChanged: (_isFavorite) {
                              fetchFavourites();
                              if (_isFavorite == true) {
                                Provider.of<CocktailsProvider>(context,
                                        listen: false)
                                    .addFavourite(cocktail.strDrink, false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      '${cocktail.strDrink} is added to Favourites'),
                                  duration: const Duration(seconds: 2),
                                ));
                              } else {
                                var f = favourites.firstWhere((element) =>
                                    element.title == cocktail.strDrink);
                                Provider.of<CocktailsProvider>(context,
                                        listen: false)
                                    .removeFavourite(f);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${cocktail.strDrink} is removed from Cocktails'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            }),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    ]);
  }
}
