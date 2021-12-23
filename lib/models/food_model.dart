class Food {
  Food({
    this.name,
    this.category,
    this.calorie,
  });

  Food.fromJson(dynamic json) {
    name = json['name'];
    category = json['category'];
    calorie = json['calorie'];
  }
  String name;
  String category;
  String calorie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['category'] = category;
    map['calorie'] = calorie;

    return map;
  }
}
