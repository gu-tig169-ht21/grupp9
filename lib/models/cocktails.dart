class Cocktails {
  final String idDrink;
  final String strDrink;
  final String strDrinkAlternate;
  final String strTags;
  final String strVideo;
  final String strCategory;
  final String strIBA;
  final String strAlcoholic;
  final String strGlass;
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
  final String strImageSource;
  final String strImageAttribution;
  final String strCreativeCommonsConfirmed;
  final String dateModified;

  const Cocktails({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkAlternate,
    required this.strTags,
    required this.strVideo,
    required this.strCategory,
    required this.strIBA,
    required this.strAlcoholic,
    required this.strGlass,
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
    required this.strImageSource,
    required this.strImageAttribution,
    required this.strCreativeCommonsConfirmed,
    required this.dateModified,
  });

  factory Cocktails.fromJson(Map<String, dynamic> json) {
    return Cocktails(
      idDrink: (json['idDrink'] != null) ? json['idDrink'] as String : '',
      strDrink: (json['strDrink'] != null) ? json['strDrink'] as String : '',
      strDrinkAlternate: (json['strDrinkAlternate'] != null)
          ? json['strDrinkAlternate'] as String
          : '',
      strTags: (json['strTags'] != null) ? json['strTags'] as String : '',
      strVideo: (json['strVideo'] != null) ? json['strVideo'] as String : '',
      strCategory:
          (json['strCategory'] != null) ? json['strCategory'] as String : '',
      strIBA: (json['strIBA'] != null) ? json['strIBA'] as String : '',
      strAlcoholic:
          (json['strAlcoholic'] != null) ? json['strAlcoholic'] as String : '',
      strGlass: (json['strGlass'] != null) ? json['strGlass'] as String : '',
      strInstructions: (json['strInstructions'] != null)
          ? json['strInstructions'] as String
          : '',
      strDrinkThumb: (json['strDrinkThumb'] != null)
          ? json['strDrinkThumb'] as String
          : '',
      strIngredient1: (json["strMeasure1"] != null)
          ? json["strIngredient1"] + " - " + json["strMeasure1"] as String
          : (json["strIngredient1"] != null)
              ? json["strIngredient1"] as String
              : '',
      strIngredient2: (json["strMeasure2"] != null)
          ? json["strIngredient2"] + " - " + json["strMeasure2"] as String
          : (json["strIngredient2"] != null)
              ? json["strIngredient2"] as String
              : '',
      strIngredient3: (json["strMeasure3"] != null)
          ? json["strIngredient3"] + " - " + json["strMeasure3"] as String
          : (json["strIngredient3"] != null)
              ? json["strIngredient3"] as String
              : '',
      strIngredient4: (json["strMeasure4"] != null)
          ? json["strIngredient4"] + " - " + json["strMeasure4"] as String
          : (json["strIngredient4"] != null)
              ? json["strIngredient4"] as String
              : '',
      strIngredient5: (json["strMeasure5"] != null)
          ? json["strIngredient5"] + " - " + json["strMeasure5"] as String
          : (json["strIngredient5"] != null)
              ? json["strIngredient5"] as String
              : '',
      strIngredient6: (json["strMeasure6"] != null)
          ? json["strIngredient6"] + " - " + json["strMeasure6"] as String
          : (json["strIngredient6"] != null)
              ? json["strIngredient6"] as String
              : '',
      strIngredient7: (json["strMeasure7"] != null)
          ? json["strIngredient7"] + " - " + json["strMeasure7"] as String
          : (json["strIngredient7"] != null)
              ? json["strIngredient7"] as String
              : '',
      strIngredient8: (json["strMeasure8"] != null)
          ? json["strIngredient8"] + " - " + json["strMeasure8"] as String
          : (json["strIngredient8"] != null)
              ? json["strIngredient8"] as String
              : '',
      strIngredient9: (json["strMeasure9"] != null)
          ? json["strIngredient9"] + " - " + json["strMeasure9"] as String
          : (json["strIngredient9"] != null)
              ? json["strIngredient9"] as String
              : '',
      strIngredient10: (json["strMeasure10"] != null)
          ? json["strIngredient10"] + " - " + json["strMeasure10"] as String
          : (json["strIngredient10"] != null)
              ? json["strIngredient10"] as String
              : '',
      strIngredient11: (json["strMeasure11"] != null)
          ? json["strIngredient11"] + " - " + json["strMeasure11"] as String
          : (json["strIngredient11"] != null)
              ? json["strIngredient11"] as String
              : '',
      strIngredient12: (json["strMeasure12"] != null)
          ? json["strIngredient12"] + " - " + json["strMeasure12"] as String
          : (json["strIngredient12"] != null)
              ? json["strIngredient12"] as String
              : '',
      strIngredient13: (json["strMeasure13"] != null)
          ? json["strIngredient13"] + " - " + json["strMeasure13"] as String
          : (json["strIngredient13"] != null)
              ? json["strIngredient13"] as String
              : '',
      strIngredient14: (json["strMeasure14"] != null)
          ? json["strIngredient14"] + " - " + json["strMeasure14"] as String
          : (json["strIngredient14"] != null)
              ? json["strIngredient14"] as String
              : '',
      strIngredient15: (json["strMeasure15"] != null)
          ? json["strIngredient15"] + " - " + json["strMeasure15"] as String
          : (json["strIngredient15"] != null)
              ? json["strIngredient15"] as String
              : '',
      strImageSource: (json['strImageSource'] != null)
          ? json['strImageSource'] as String
          : '',
      strImageAttribution: (json['strImageAttribution'] != null)
          ? json['strImageAttribution'] as String
          : '',
      strCreativeCommonsConfirmed: (json['strCreativeCommonsConfirmed'] != null)
          ? json['strCreativeCommonsConfirmed'] as String
          : '',
      dateModified:
          (json['dateModified'] != null) ? json['dateModified'] as String : '',
    );
  }
}
