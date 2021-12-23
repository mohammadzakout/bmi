class BmiRecord {
  BmiRecord({
    this.date,
    this.status,
    this.weight,
    this.height,
    this.record,
  });

  BmiRecord.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'];
    weight = json['weight'];
    height = json['height'];
    record = json['record'];
  }
  String date;
  String status;
  double record;
  int weight;
  int height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['weight'] = weight;
    map['height'] = height;
    map['record'] = record;
    map['date'] = date;
    map['status'] = status;
    return map;
  }
}
