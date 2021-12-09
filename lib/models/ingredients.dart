class Ingredients {
  final String id;
  final String title;
  final bool done;

  const Ingredients(
      {required this.id, required this.title, required this.done});

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }
}
