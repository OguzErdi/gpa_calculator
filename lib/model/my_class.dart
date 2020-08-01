class MyClass {
  String name = "";
  int credit = 3;
  double score;
  String scoreStr;

  MyClass();

  MyClass.special({
    this.name,
    this.credit,
    this.score,
    this.scoreStr,
  });

  @override
  String toString() {
    return "name: $name | credit number: $credit | score: $scoreStr";
  }
}
