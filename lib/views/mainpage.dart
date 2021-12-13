import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/views/cocktails.dart';
import 'package:my_first_app/views/favourites.dart';
import 'package:my_first_app/views/home.dart';
import 'package:my_first_app/views/ingredients.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final screens = [Home(), Ingredients(), Cocktailsvy(), Favourites()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey.withOpacity(0.5),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40),
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
            selectedItemColor: Colors.black,
            onTap: _onItemTapped));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
