class BmiAppUser {
  BmiAppUser({
    this.name,
    this.gender,
    this.weight,
    this.height,
    this.dateOfBirth,
    this.email,
  });

  BmiAppUser.fromJson(dynamic json) {
    name = json['name'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
  }
  String name;
  String gender;
  int weight;
  int height;
  String dateOfBirth;
  String email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gender'] = gender;
    map['weight'] = weight;
    map['height'] = height;
    map['date_of_birth'] = dateOfBirth;
    map['email'] = email;
    return map;
  }
}
