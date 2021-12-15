import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';

class Details extends StatelessWidget {
  final Cocktails cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0.15),
          title: Text(
            (cocktail.strDrink),
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Text(cocktail.strIngredient1),
                    Text(cocktail.strInstructions),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          height: 300,
                          child: Image.network(cocktail.strDrinkThumb)),
                    )
                  ],
                ),
              ),
            )));
  }
}
