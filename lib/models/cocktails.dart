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
    var i1 = '';
    var i2 = '';
    var i3 = '';
    var i4 = '';
    var i5 = '';
    var i6 = '';
    var i7 = '';
    var i8 = '';
    var i9 = '';
    var i10 = '';
    var i11 = '';
    var i12 = '';
    var i13 = '';
    var i14 = '';
    var i15 = '';

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

    i1 = maybeAddIngredient(json["strIngredient1"], json["strMeasure1"]);
    i2 = maybeAddIngredient(json["strIngredient2"], json["strMeasure2"]);
    i3 = maybeAddIngredient(json["strIngredient3"], json["strMeasure3"]);
    i4 = maybeAddIngredient(json["strIngredient4"], json["strMeasure4"]);
    i5 = maybeAddIngredient(json["strIngredient5"], json["strMeasure5"]);
    i6 = maybeAddIngredient(json["strIngredient6"], json["strMeasure6"]);
    i7 = maybeAddIngredient(json["strIngredient7"], json["strMeasure7"]);
    i8 = maybeAddIngredient(json["strIngredient8"], json["strMeasure8"]);
    i9 = maybeAddIngredient(json["strIngredient9"], json["strMeasure9"]);
    i10 = maybeAddIngredient(json["strIngredient10"], json["strMeasure10"]);
    i11 = maybeAddIngredient(json["strIngredient11"], json["strMeasure11"]);
    i12 = maybeAddIngredient(json["strIngredient12"], json["strMeasure12"]);
    i13 = maybeAddIngredient(json["strIngredient13"], json["strMeasure13"]);
    i14 = maybeAddIngredient(json["strIngredient14"], json["strMeasure14"]);
    i15 = maybeAddIngredient(json["strIngredient15"], json["strMeasure15"]);

    return Cocktails(
        strDrink: (json['strDrink'] != null) ? json['strDrink'] as String : '',
        strInstructions: (json['strInstructions'] != null)
            ? json['strInstructions'] as String
            : '',
        strDrinkThumb: (json['strDrinkThumb'] != null)
            ? json['strDrinkThumb'] as String
            : '',
        strIngredient1: i1,
        strIngredient2: i2,
        strIngredient3: i3,
        strIngredient4: i4,
        strIngredient5: i5,
        strIngredient6: i6,
        strIngredient7: i7,
        strIngredient8: i8,
        strIngredient9: i9,
        strIngredient10: i10,
        strIngredient11: i11,
        strIngredient12: i12,
        strIngredient13: i13,
        strIngredient14: i14,
        strIngredient15: i15,
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
}
