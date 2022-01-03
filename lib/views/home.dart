import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import '/models/cocktails.dart';
import 'package:provider/provider.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              backgroundColor: Colors.grey.withOpacity(0.15),
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
                return Rad(data.list[0]);
              }
            }),
          ),
        ),
      );
    });
  }
}

class Rad extends StatelessWidget {
  final list = [
    '“Different cocktails for different Saturday nights.” ― Drew Barrymore',
    '“No amount of physical contact could match the healing powers of a well made cocktail.” — David Sedaris',
    'Cenosillicaphobia (noun): the fear of an empty glass',
    'When life gives you lemons, make whiskey sours',
    '“Shaken, not stirred.” —James Bond',
  ];
  final _random = Random();
  late var element = list[_random.nextInt(4)];
  final Cocktails cocktail;

  Rad(this.cocktail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(element),
              Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 5),
                  child: Text(cocktail.strDrink),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff2c2c2c).withOpacity(0.6),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    cocktail: cocktail.strDrink,
                                  )),
                        );
                      },
                      child: Image.network(cocktail.strDrinkThumb),
                    )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
