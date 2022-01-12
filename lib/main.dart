import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/cocktails_provider.dart';

void main() {
  var cocktailsProvider = CocktailsProvider();
  cocktailsProvider.getRandomQuote();
  cocktailsProvider.getRandomCocktail();
  cocktailsProvider.getFavourites();
  cocktailsProvider.getIngredients();
  //cocktailsProvider.getCocktails();
  //cocktailsProvider.getNonAlcCocktails();
  runApp(ChangeNotifierProvider(
      create: (context) => cocktailsProvider, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cocktaily',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white,
                  )),
        ),
        home: const Navigation());
  }
}
