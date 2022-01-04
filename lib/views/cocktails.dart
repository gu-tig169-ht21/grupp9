import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/widgets/cocktails_search.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:my_first_app/views/details.dart';
import 'package:provider/provider.dart';

class DrinksView extends StatefulWidget {
  const DrinksView({Key? key}) : super(key: key);
  @override
  _DrinksViewState createState() => _DrinksViewState();
}

class _DrinksViewState extends State<DrinksView> {
  var url =
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic';
  var url2 =
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic';

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
    cocktails = [];
    var res = await http.get(Uri.parse(url));
    var drinks = jsonDecode(res.body)['drinks'];

    cocktails = drinks.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();

    setState(() {});
  }

  fetchNonAlcCocktails() async {
    cocktails = [];
    var res = await http.get(Uri.parse(url2));
    var drinks = jsonDecode(res.body)['drinks'];

    cocktails = drinks.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();

    setState(() {});
  }

  bool checkFavourite(String drink) {
    return favourites.any((f) => f.title == drink);
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
                    PopupMenuButton<String>(
                      color: Colors.black,
                      icon: const Icon(
                        Icons.filter_list_alt,
                        color: Colors.white,
                      ),
                      onSelected: (value) async {
                        setState(() {
                          setFilter(value);
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            child: Text('Alcoholic'), value: '1'),
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
                                      Provider.of<FavouritesProvider>(context,
                                              listen: false)
                                          .addFavourite(
                                              cocktail.strDrink, false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            '${cocktail.strDrink} is added to Favourites'),
                                      ));
                                    } else {
                                      var f = favourites.firstWhere((element) =>
                                          element.title == cocktail.strDrink);
                                      Provider.of<FavouritesProvider>(context,
                                              listen: false)
                                          .removeFavourite(f);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            '${cocktail.strDrink} is removed from Favourites'),
                                      ));
                                    }
                                  })),
                        );
                      }),
                ),
              )))
    ]);
  }
}
