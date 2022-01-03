import 'package:flutter/material.dart';
import 'package:my_first_app/views/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/favourites_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favouritesProvider = FavouritesProvider();
    favouritesProvider.getRandomCocktail();
    favouritesProvider.getFavourites();
    return ChangeNotifierProvider(
        create: (context) => favouritesProvider,
        child: MaterialApp(
            title: 'Cocktaily',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                      )),
            ),
            home: const NavigationBar()));
  }
}
