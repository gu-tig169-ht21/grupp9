class Favourites {
  final String id;
  final String title;
  final bool done;

  const Favourites({required this.id, required this.title, required this.done});

  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }
}
