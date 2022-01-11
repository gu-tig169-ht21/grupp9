import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import '/models/cocktails.dart';
import 'package:provider/provider.dart';
import 'details.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.black12.withOpacity(0.8),
            title: const Text(
              ('Cocktaily'),
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: Consumer<CocktailsProvider>(
              builder: (context, CocktailsProvider data, child) {
            if (data.rlist.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Loading'),
              );
            } else {
              return Quotes(data.rlist[0]);
            }
          }),
        ),
      ),
    );
  }
}

class Quotes extends StatelessWidget {
  final Cocktails cocktail;

  const Quotes(this.cocktail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
                Provider.of<CocktailsProvider>(context, listen: false).quote,
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
