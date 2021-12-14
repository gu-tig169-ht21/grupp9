import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail';
  var res;
  var cocktails = [];

  @override
  void initState() {
    super.initState();

    fetchCocktails();
  }

  fetchCocktails() async {
    res = await http.get(Uri.parse(url));
    cocktails = jsonDecode(res.body)['drinks'];
    setState(() {});
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
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: const Center(
                      child: Text(
                        'Favourites',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    backgroundColor: Colors.black12.withOpacity(0.65),
                    elevation: 0.0,
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
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 44,
                                    maxHeight: 44,
                                  ),
                                  // child:
                                  //     Image.network(cocktail.strDrinkThumb)
                                ),
                                title: Text("${cocktail["strDrink"]}",
                                    style: const TextStyle(
                                        fontSize: 21, color: Colors.white)),
                                trailing: FavoriteButton(
                                  iconSize: 30,
                                  isFavorite: false,
                                  valueChanged: (_isFavorite) {
                                    print('is favorite : $_isFavorite');
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              )))
    ]);
  }
}
