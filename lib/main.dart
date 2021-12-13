import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cocktails_provider.dart';
import 'views/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Home()));
  }
}
