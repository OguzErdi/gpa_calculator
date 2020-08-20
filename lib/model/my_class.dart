import 'dart:convert';

class MyClass {
  String name = "";
  int credit;
  double score;
  String scoreStr = "";

  MyClass(
    this.name,
    this.credit,
    this.score,
    this.scoreStr,
  );

  MyClass.special({
    this.name,
    this.credit,
    this.score,
    this.scoreStr,
  });

  @override
  String toString() {
    return 'MyClass(name: $name, credit: $credit, score: $score, scoreStr: $scoreStr)';
  }

  MyClass copyWith({
    String name,
    int credit,
    double score,
    String scoreStr,
  }) {
    return MyClass(
      name ?? this.name,
      credit ?? this.credit,
      score ?? this.score,
      scoreStr ?? this.scoreStr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'credit': credit,
      'score': score,
      'scoreStr': scoreStr,
    };
  }

  factory MyClass.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MyClass(
      map['name'],
      map['credit'],
      map['score'],
      map['scoreStr'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyClass.fromJson(String source) => MyClass.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is MyClass &&
      o.name == name &&
      o.credit == credit &&
      o.score == score &&
      o.scoreStr == scoreStr;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      credit.hashCode ^
      score.hashCode ^
      scoreStr.hashCode;
  }
}
