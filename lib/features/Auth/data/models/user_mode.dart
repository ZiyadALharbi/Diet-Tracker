class UserModel {
  String name;
  String email;
  String username;
  String password;
  String? goal;
  String? gender;
  String? activity;
  double? height;
  double? weight;
  int? age;

  UserModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    this.goal = "keep weight",
    this.gender = "male",
    this.activity = "active",
    this.height,
    this.weight,
    this.age,
  });

  // Convert UserModel to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "username": username,
      "password": password,
      "goal": goal,
      "gender": gender,
      "activity": activity,
      "height": height,
      "weight": weight,
      "age": age,
    };
  }

  // Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      goal: json['goal'],
      gender: json['gender'],
      activity: json['activity'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      age: json['age'] as int?,
    );
  }
}
