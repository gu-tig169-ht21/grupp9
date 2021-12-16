import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final Cocktails cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState(cocktail: cocktail);
}

class _DetailsState extends State<Details> {
  final Cocktails cocktail;
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';
  var res;
  var _cocktail;
  _DetailsState({Key? key, required this.cocktail});

  @override
  void initState() {
    super.initState();

    fetchCocktail();
  }

  fetchCocktail() async {
    res = await http.get(Uri.parse(url + cocktail.strDrink));
    var drinks = jsonDecode(res.body)['drinks'][0];

    _cocktail = Cocktails.fromJson(drinks);

    setState(() {});
  }

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
                    Text((_cocktail == null) ? "" : _cocktail.strIngredient1,
                        style: const TextStyle(color: Colors.white)),
                    Text((_cocktail == null) ? "" : _cocktail.strInstructions,
                        style: const TextStyle(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          height: 300,
                          child: Image.network((_cocktail == null)
                              ? "https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
                              : _cocktail.strDrinkThumb)),
                    )
                  ],
                ),
              ),
            )));
  }
}
