import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/models/cocktails.dart';
import 'package:my_first_app/models/ingredients_search.dart';

class IngrediensVy extends StatefulWidget {
  @override
  _IngrediensVyState createState() => _IngrediensVyState();
}

class _IngrediensVyState extends State<IngrediensVy> {
  var api = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list";
  var res;
  var ingredients = [];
  var cocktails = [];
  final _controller = TextEditingController();
  bool check = false;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    res = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'));
    ingredients = jsonDecode(res.body)["drinks"];
    setState(() {});
  }

  fetchCockails(String ingredient) async {
    res = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
            ingredient));
    var drinks = jsonDecode(res.body)["drinks"];
    cocktails = drinks.map<Cocktails>((data) {
      return Cocktails.fromJson(data);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: const Center(
                        child: Text(
                          "Ingredients",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      backgroundColor: Colors.black12.withOpacity(0.65),
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: IngredientSearch(ingredients));
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    body: Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.builder(
                          itemCount: ingredients.length,
                          itemBuilder: (context, index) {
                            var ingredient = ingredients[index];
                            return Card(
                              color: Colors.black12.withOpacity(0.4),
                              child: ListTile(
                                  leading: Text(
                                      "${ingredient["strIngredient1"]}",
                                      style: const TextStyle(fontSize: 21)),
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate: IngredientSearch(ingredients),
                                        query: ingredient['strIngredient1']);
                                  }),
                            );
                          }),
                    )),
              )))
    ]);
  }
}
