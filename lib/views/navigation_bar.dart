import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/views/cocktails.dart';
import 'package:my_first_app/views/favourites.dart';
import 'package:my_first_app/views/home.dart';
import 'package:my_first_app/views/ingredients.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final screens = [
    const Home(),
    const Ingredients(),
    const DrinksView(),
    const Favourites(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.grey[600],
            unselectedItemColor: Colors.grey[300],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[900],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Hem',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science_outlined, size: 30),
                label: 'Ingredienser',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_bar, size: 30),
                label: 'Alla drinkar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30),
                label: 'Favoriter',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
