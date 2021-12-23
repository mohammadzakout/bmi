import 'package:bmi/helpers/constents.dart';
import 'package:bmi/models/bmi_record.dart';

class BMIHelper {
  static const underweight = ["SB", "SB", "SB", "LC", "LC", "SG", "GA", "GA"];
  static const normalweight = ["SB", "BC", "BC", "LC", "LC", "BC", "BC", "BC"];
  static const overweight = ["BC", "GA", "SG", "LC", "LC", "BC", "SB", "SB"];
  static const obesity = ["GA", "GA", "LC", "LC", "BC", "SB", "SB", "SB"];

  static BmiRecord getRecord(
      {int weight, int height, int age, String gender, String date}) {
    double result = ((weight) / (height * height)) * 100;
    int percentage = 100;
    if (age <= 10)
      percentage = 70;
    else if (age > 10 && age < 20) {
      percentage = 90;
      if (gender == Gender.female) percentage = 80;
    }
    double bmi = result * percentage;
    print(bmi);
    String status = "Underweight";
    if (bmi >= 18.5 && bmi < 25) status = "Normal";
    if (bmi >= 25 && bmi < 30) status = "Overweight";
    if (bmi >= 30) status = "Obesity";
    print(status);

    return BmiRecord(
        status: status,
        record: bmi,
        height: height,
        weight: weight,
        date: date);
  }

  static String getCurrentStatus(
      {double previous, double current, String oldStatus}) {
    if (previous == 0 || current == 0) {
      return oldStatus;
    }
    print(previous.toString());
    print(current);
    double delta = current - previous;
    int index = getSatusOfDelta(delta);
    switch (oldStatus) {
      case "Underweight":
        return getStatusString(status: underweight[index]);

      case "Normal":
        return getStatusString(status: normalweight[index]);

      case "Overweight":
        return getStatusString(status: overweight[index]);

      case "Obesity":
        return getStatusString(status: obesity[index]);

        return current.toString();
    }
  }

  static int getSatusOfDelta(double delta) {
    if (delta < -1) return 0;
    if (delta >= -1 && delta < -0.6) return 1;
    if (delta >= -0.6 && delta < -0.3) return 2;
    if (delta >= -0.3 && delta < 0) return 3;
    if (delta >= 0 && delta < 0.3) return 4;
    if (delta >= 0.3 && delta < 0.6) return 5;
    if (delta >= 0.6 && delta <= 1) return 6;
    if (delta >= 1) return 7;
  }

  static String getStatusString({String status}) {
    switch (status) {
      case "SB":
        return "Still Good";

      case "LC":
        return "Little Changes";

      case "GA":
        return "Go Ahead";

      case "BC":
        return "Be Careful";

      default:
        return "So Bad";
    }
  }
}
