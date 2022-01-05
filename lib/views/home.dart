import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import '/models/cocktails.dart';
import 'package:provider/provider.dart';
import 'details.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.black12.withOpacity(0.8),
              title: const Text(
                ('Cocktaily'),
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
            ),
            body: Consumer<FavouritesProvider>(
                builder: (context, FavouritesProvider data, child) {
              if (data.list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Loading'),
                );
              } else {
                return Quotes(data.list[0]);
              }
            }),
          ),
        ),
      );
    });
  }
}

class Quotes extends StatelessWidget {
  final list = [
    '“Different cocktails for different Saturday nights.” ― Drew Barrymore',
    '“No amount of physical contact could match the healing powers of a well made cocktail.” — David Sedaris',
    '"Cenosillicaphobia (noun): the fear of an empty glass"',
    '"When life gives you lemons, make whiskey sours"',
    '“Shaken, not stirred.” —James Bond',
  ];
  final _random = Random();
  final Cocktails cocktail;

  Quotes(this.cocktail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(list[_random.nextInt(4)],
                style: const TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
            ),
            child: Container(
              width: 300,
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                cocktail: cocktail.strDrink,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(cocktail.strDrink),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                cocktail: cocktail.strDrink,
                              )),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(cocktail.strDrinkThumb),
                        )),
                  ),
                ),
              ]),
            ),
          ),
        ]));
  }
}
