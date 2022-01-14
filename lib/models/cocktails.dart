class Cocktails {
  final String strDrink;
  final String strInstructions;
  final String strDrinkThumb;
  final String strIngredient1;
  final String strIngredient2;
  final String strIngredient3;
  final String strIngredient4;
  final String strIngredient5;
  final String strIngredient6;
  final String strIngredient7;
  final String strIngredient8;
  final String strIngredient9;
  final String strIngredient10;
  final String strIngredient11;
  final String strIngredient12;
  final String strIngredient13;
  final String strIngredient14;
  final String strIngredient15;
  final List ingredientsList;

  const Cocktails({
    required this.strDrink,
    required this.strInstructions,
    required this.strDrinkThumb,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    required this.strIngredient5,
    required this.strIngredient6,
    required this.strIngredient7,
    required this.strIngredient8,
    required this.strIngredient9,
    required this.strIngredient10,
    required this.strIngredient11,
    required this.strIngredient12,
    required this.strIngredient13,
    required this.strIngredient14,
    required this.strIngredient15,
    required this.ingredientsList,
  });

  static Cocktails fromJson(Map<String, dynamic> json) {
    var list = [];

    String maybeAddIngredient(ingredient, measure) {
      if (measure != null) {
        var str = ingredient + " - " + measure as String;
        list.add(str);
        return str;
      } else if (ingredient != null) {
        var str = ingredient as String;
        list.add(str);
        return str;
      }
      return '';
    }

    return Cocktails(
        strDrink: (json['strDrink'] != null) ? json['strDrink'] as String : '',
        strInstructions: (json['strInstructions'] != null)
            ? json['strInstructions'] as String
            : '',
        strDrinkThumb: (json['strDrinkThumb'] != null)
            ? json['strDrinkThumb'] as String
            : '',
        strIngredient1:
            maybeAddIngredient(json["strIngredient1"], json["strMeasure1"]),
        strIngredient2:
            maybeAddIngredient(json["strIngredient2"], json["strMeasure2"]),
        strIngredient3:
            maybeAddIngredient(json["strIngredient3"], json["strMeasure3"]),
        strIngredient4:
            maybeAddIngredient(json["strIngredient4"], json["strMeasure4"]),
        strIngredient5:
            maybeAddIngredient(json["strIngredient5"], json["strMeasure5"]),
        strIngredient6:
            maybeAddIngredient(json["strIngredient6"], json["strMeasure6"]),
        strIngredient7:
            maybeAddIngredient(json["strIngredient7"], json["strMeasure7"]),
        strIngredient8:
            maybeAddIngredient(json["strIngredient8"], json["strMeasure8"]),
        strIngredient9:
            maybeAddIngredient(json["strIngredient9"], json["strMeasure9"]),
        strIngredient10:
            maybeAddIngredient(json["strIngredient10"], json["strMeasure10"]),
        strIngredient11:
            maybeAddIngredient(json["strIngredient11"], json["strMeasure11"]),
        strIngredient12:
            maybeAddIngredient(json["strIngredient12"], json["strMeasure12"]),
        strIngredient13:
            maybeAddIngredient(json["strIngredient13"], json["strMeasure13"]),
        strIngredient14:
            maybeAddIngredient(json["strIngredient14"], json["strMeasure14"]),
        strIngredient15:
            maybeAddIngredient(json["strIngredient15"], json["strMeasure15"]),
        ingredientsList: list);
  }

  static Cocktails empty() {
    return const Cocktails(
      strDrink: '',
      strInstructions: '',
      strDrinkThumb: '',
      strIngredient1: '',
      strIngredient2: '',
      strIngredient3: '',
      strIngredient4: '',
      strIngredient5: '',
      strIngredient6: '',
      strIngredient7: '',
      strIngredient8: '',
      strIngredient9: '',
      strIngredient10: '',
      strIngredient11: '',
      strIngredient12: '',
      strIngredient13: '',
      strIngredient14: '',
      strIngredient15: '',
      ingredientsList: [],
    );
  }

  static Cocktails searchSuggestion(String cocktailname) {
    return Cocktails(
      strDrink: cocktailname,
      strInstructions: '',
      strDrinkThumb: '',
      strIngredient1: '',
      strIngredient2: '',
      strIngredient3: '',
      strIngredient4: '',
      strIngredient5: '',
      strIngredient6: '',
      strIngredient7: '',
      strIngredient8: '',
      strIngredient9: '',
      strIngredient10: '',
      strIngredient11: '',
      strIngredient12: '',
      strIngredient13: '',
      strIngredient14: '',
      strIngredient15: '',
      ingredientsList: [],
    );
  }
}
