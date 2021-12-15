import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/cocktails.dart';
import '/providers/cocktails_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  /*final _pageOptions = [
    Ingredients(),
    Cocktails(),
    Favourites()
  ];*/

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
              foregroundColor: Colors.white,
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
                if (data.list.length == 0) {
                  return Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              element,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
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
                              ])
                        ],
                      ),
                    ),
                  );
                } else {
                  return Rad(data.list[0], element);
                }
              }),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.grey.withOpacity(0.5),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_sharp, size: 40),
                  label: 'Hem',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.kitchen, size: 40),
                  label: 'Ingredienser',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_bar, size: 40),
                  label: 'Alla drinkar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 40),
                  label: 'Favoriter',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Rad extends StatelessWidget {
  final Cocktails cocktail;
  final String quote;
  Rad(this.cocktail, this.quote);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                quote,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: const Alignment(0.0, -0.8),
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      width: 300.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff2c2c2c).withOpacity(0.6),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.network(cocktail.strDrinkThumb),
                      )),
                  Text(cocktail.strDrink)
                ])
          ],
        ),
      ),
    );
  }
}
