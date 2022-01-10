import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:my_first_app/searchviews/ingredients_search.dart';
import 'package:provider/provider.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({Key? key}) : super(key: key);

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
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "Ingredients",
                  ),
                  backgroundColor: Colors.black12.withOpacity(0.85),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: IngredientSearch(
                                  Provider.of<CocktailsProvider>(context,
                                          listen: false)
                                      .ingredients));
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                body: Scrollbar(
                    isAlwaysShown: true,
                    child: Consumer<CocktailsProvider>(
                        builder: (context, CocktailsProvider data, child) {
                      return ListView.builder(
                          itemCount: data.ingredients.length,
                          itemBuilder: (context, index) {
                            var ingredient = data.ingredients[index];
                            return Card(
                              color: Colors.black12.withOpacity(0.4),
                              child: ListTile(
                                  leading: Text(
                                      "${ingredient["strIngredient1"]}",
                                      style: const TextStyle(fontSize: 21)),
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate:
                                            IngredientSearch(data.ingredients),
                                        query: ingredient['strIngredient1']);
                                  }),
                            );
                          });
                    })),
              )))
    ]);
  }
}
