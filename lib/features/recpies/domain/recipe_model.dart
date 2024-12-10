class Recipe {
  final String id;
  final String name;
  final String description;
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;
  final int grams;
  final String? photo;
  final String? videoLink;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    required this.grams,
    this.photo,
    this.videoLink,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      calories: json['calories'],
      proteins: json['proteins'],
      fats: json['fats'],
      carbs: json['carbs'],
      grams: json['grams'],
      photo: json['photo'],
      videoLink: json['videoLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbs': carbs,
      'grams': grams,
      'photo': photo,
      'videoLink': videoLink,
    };
  }
}
