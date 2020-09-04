import 'grade_type_list.dart';

class AAGradeType implements GradeTypeList {
  @override
  Map<String, double> list;
  static final AAGradeType _singleton = AAGradeType._internal();

  factory AAGradeType() {
    _singleton.list = {
      "AA": 4.0,
      "BA": 3.5,
      "BB": 3.0,
      "CB": 2.5,
      "CC": 2.0,
      "DC": 1.5,
      "DD": 1.0,
      "FF": 0.0,
      "NA": 0.0,
    };

    return _singleton;
  }

  AAGradeType._internal();
}