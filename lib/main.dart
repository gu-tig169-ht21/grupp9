import 'package:flutter/material.dart';
import 'package:my_first_app/views/mainpage.dart';
import 'package:provider/provider.dart';
import 'providers/cocktails_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cocktailsProvider = CocktailsProvider();
    cocktailsProvider.getRandomCocktail();
    return ChangeNotifierProvider(
        create: (context) => cocktailsProvider,
        child: MaterialApp(
            title: 'Cocktaily',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.recursiveTextTheme(
                  Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      )),
            ),
            home: MainPage()));
  }
}
