class Cocktails {
  final String strDrink;
  final String strAlcoholic;
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
    required this.strAlcoholic,
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

  factory Cocktails.fromJson(Map<String, dynamic> json) {
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

    if (json["strMeasure1"] != null) {
      i1 = json["strIngredient1"] + " - " + json["strMeasure1"] as String;
      list.add(i1);
    } else if (json["strIngredient1"] != null) {
      i1 = json["strIngredient1"] as String;
      list.add(i1);
    }

    if (json["strMeasure2"] != null) {
      i2 = json["strIngredient2"] + " - " + json["strMeasure2"] as String;
      list.add(i2);
    } else if (json["strIngredient2"] != null) {
      i2 = json["strIngredient2"] as String;
      list.add(i2);
    }

    if (json["strMeasure3"] != null) {
      i3 = json["strIngredient3"] + " - " + json["strMeasure3"] as String;
      list.add(i3);
    } else if (json["strIngredient3"] != null) {
      i3 = json["strIngredient3"] as String;
      list.add(i3);
    }

    if (json["strMeasure4"] != null) {
      i4 = json["strIngredient4"] + " - " + json["strMeasure4"] as String;
      list.add(i4);
    } else if (json["strIngredient4"] != null) {
      i4 = json["strIngredient4"] as String;
      list.add(i4);
    }

    if (json["strMeasure5"] != null) {
      i5 = json["strIngredient5"] + " - " + json["strMeasure5"] as String;
      list.add(i5);
    } else if (json["strIngredient5"] != null) {
      i5 = json["strIngredient5"] as String;
      list.add(i5);
    }

    if (json["strMeasure6"] != null) {
      i6 = json["strIngredient6"] + " - " + json["strMeasure6"] as String;
      list.add(i6);
    } else if (json["strIngredient6"] != null) {
      i6 = json["strIngredient6"] as String;
      list.add(i6);
    }

    if (json["strMeasure7"] != null) {
      i7 = json["strIngredient7"] + " - " + json["strMeasure7"] as String;
      list.add(i7);
    } else if (json["strIngredient7"] != null) {
      i7 = json["strIngredient7"] as String;
      list.add(i7);
    }

    if (json["strMeasure8"] != null) {
      i8 = json["strIngredient8"] + " - " + json["strMeasure8"] as String;
      list.add(i8);
    } else if (json["strIngredient8"] != null) {
      i8 = json["strIngredient8"] as String;
      list.add(i8);
    }

    if (json["strMeasure9"] != null) {
      i9 = json["strIngredient9"] + " - " + json["strMeasure9"] as String;
      list.add(i9);
    } else if (json["strIngredient9"] != null) {
      i9 = json["strIngredient9"] as String;
      list.add(i9);
    }

    if (json["strMeasure10"] != null) {
      i10 = json["strIngredient10"] + " - " + json["strMeasure10"] as String;
      list.add(i10);
    } else if (json["strIngredient10"] != null) {
      i10 = json["strIngredient10"] as String;
      list.add(i10);
    }

    if (json["strMeasure11"] != null) {
      i11 = json["strIngredient11"] + " - " + json["strMeasure11"] as String;
      list.add(i11);
    } else if (json["strIngredient11"] != null) {
      i11 = json["strIngredient11"] as String;
      list.add(i11);
    }

    if (json["strMeasure12"] != null) {
      i12 = json["strIngredient12"] + " - " + json["strMeasure12"] as String;
      list.add(i12);
    } else if (json["strIngredient12"] != null) {
      i12 = json["strIngredient12"] as String;
      list.add(i12);
    }

    if (json["strMeasure13"] != null) {
      i13 = json["strIngredient13"] + " - " + json["strMeasure13"] as String;
      list.add(i13);
    } else if (json["strIngredient13"] != null) {
      i13 = json["strIngredient13"] as String;
      list.add(i13);
    }

    if (json["strMeasure14"] != null) {
      i14 = json["strIngredient14"] + " - " + json["strMeasure14"] as String;
      list.add(i14);
    } else if (json["strIngredient14"] != null) {
      i14 = json["strIngredient14"] as String;
      list.add(i14);
    }

    if (json["strMeasure15"] != null) {
      i15 = json["strIngredient15"] + " - " + json["strMeasure15"] as String;
      list.add(i15);
    } else if (json["strIngredient15"] != null) {
      i15 = json["strIngredient15"] as String;
      list.add(i15);
    }

    return Cocktails(
        strDrink: (json['strDrink'] != null) ? json['strDrink'] as String : '',
        strAlcoholic: (json['strAlcoholic'] != null)
            ? json['strAlcoholic'] as String
            : '',
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

  void maybeAddIngredient(list, ingredient, measure) {
    if (measure != null) {
      var str = ingredient + " - " + measure as String;
      list.add(str);
    } else if (ingredient != null) {
      var str = ingredient as String;
      list.add(str);
    }
  }

  factory Cocktails.empty() {
    return const Cocktails(
        strDrink: '',
        strAlcoholic: '',
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
        ingredientsList: []);
  }
}
