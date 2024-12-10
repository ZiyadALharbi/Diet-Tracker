class Recipe {
  final String name;
  final String image;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;
  final int time;
  final String description;
  final String? videoUrl; // Nullable video URL

  Recipe({
    required this.name,
    required this.image,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.time,
    required this.description,
    this.videoUrl, // Optional parameter
  });

  static fromJson(e) {}
}
