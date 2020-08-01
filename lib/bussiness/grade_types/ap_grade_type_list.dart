import 'grade_type_list.dart';

class APlusGradeType implements GradeTypeList {
  @override
  Map<String, double> list;
  static final APlusGradeType _singleton = APlusGradeType._internal();

  factory APlusGradeType() {
    _singleton.list = {
      "A+": 4.00,
      "A": 4.00,
      "A-": 3.70,
      "B+": 3.30,
      "B": 3.00,
      "B-": 2.70,
      "C+": 2.30,
      "C": 2.00,
      "C-": 1.70,
      "D+": 1.30,
      "D": 1.00,
      "F": 0.00,
    };

    return _singleton;
  }

  APlusGradeType._internal();

  
}