import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var favourites = [];

  @override
  void initState() {
    super.initState();
    fetchFavourites();
  }

  fetchFavourites() {
    favourites =
        Provider.of<CocktailsProvider>(context, listen: false).favourites;
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
                (widget.cocktail),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FavoriteButton(
                    iconSize: 30,
                    isFavorite: checkFavourite(widget.cocktail),
                    valueChanged: (_isFavorite) {
                      fetchFavourites();
                      if (_isFavorite == true) {
                        Provider.of<CocktailsProvider>(context, listen: false)
                            .addFavourite(widget.cocktail, false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('${widget.cocktail} is added to Favourites'),
                          duration: const Duration(seconds: 2),
                        ));
                      } else {
                        var f = favourites.firstWhere(
                            (element) => element.title == widget.cocktail);
                        Provider.of<CocktailsProvider>(context, listen: false)
                            .removeFavourite(f);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${widget.cocktail} is removed from Favourites'),
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    }),
              )
            ],
          ),
          extendBody: true,
          body: FutureBuilder<Cocktails>(
              future: Provider.of<CocktailsProvider>(context, listen: false)
                  .getOneCocktail(widget.cocktail),
              builder:
                  (BuildContext context, AsyncSnapshot<Cocktails> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Scrollbar(
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
                                      child: (snapshot.data != null)
                                          ? Image.network(
                                              snapshot.data!.strDrinkThumb)
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Ingredients:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 27),
                                ),
                              ),
                              (snapshot.data!.ingredientsList.isNotEmpty)
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.ingredientsList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Text(
                                          snapshot.data!.ingredientsList[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        );
                                      })
                                  : const Text('No ingredients found.',
                                      style: TextStyle(color: Colors.white)),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Instructions:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 27),
                                ),
                              ),
                              (snapshot.data!.strInstructions != '')
                                  ? Text(
                                      snapshot.data!.strInstructions,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  : const Text('No instructions found.',
                                      style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    }
                }
              }),
        ),
      ),
    );
  }
}
