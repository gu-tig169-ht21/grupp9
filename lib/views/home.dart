import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/cocktails.dart';
import '/providers/cocktails_provider.dart';
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
    List<String> list = ['a', 'b', 'c', 'd', 'e'];
    final _random = Random();

    var element = list[_random.nextInt(4)];
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.15),
            title: const Text(
              ('Cocktaily'),
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ]),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Consumer<CocktailsProvider>(
                builder: (context, CocktailsProvider data, child) {
              if (data.list.isEmpty) {
                return Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  alignment: const Alignment(0.0, -0.8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  width: 300.0,
                                  height: 300.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2c2c2c)
                                        .withOpacity(0.6),
                                  ),
                                  child: const Text('no cocktails found'))
                            ]),
                      ],
                    ),
                  ),
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
  var list = [
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
      child: ListView(
        children: [
          Text(element),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(cocktail.strDrink),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff2c2c2c).withOpacity(0.6),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  cocktail: cocktail,
                                )),
                      );
                    },
                    child: Image.network(cocktail.strDrinkThumb),
                  )),
            ]),
          )
        ],
      ),
    );
  }
}
