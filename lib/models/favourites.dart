class FavouritesModel {
  final String id;
  final String title;
  final bool done;

  const FavouritesModel(
      {required this.id, required this.title, required this.done});

  factory FavouritesModel.fromJson(Map<String, dynamic> json) {
    return FavouritesModel(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }
}
