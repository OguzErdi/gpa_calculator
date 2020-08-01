import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/bussiness/grade_types/aa_grade_type_list.dart';
import 'package:gpa_calculator/bussiness/grade_types/ap_grade_type_list.dart';
import 'package:gpa_calculator/bussiness/grade_types/grade_type_list.dart';
import 'package:gpa_calculator/model/my_class.dart';
import 'class_list.dart';
import 'gpa_drawer.dart';

class GPAHomePage extends StatefulWidget {
  @override
  _GPAHomePageState createState() => _GPAHomePageState();
}

class _GPAHomePageState extends State<GPAHomePage> {
  List<int> _creditList;
  GradeTypeList _gradeList;
  double borderWidth = 1;
  double borderRadius = 10;
  double horizontalWidth = 20;

  int selectedCredit;
  String selectedScoreStr;

  MyClass _newClass;
  List<MyClass> _classList;
  double gpa = 0;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _creditList = List.generate(10, (index) => index + 1);

    _gradeList = APlusGradeType();

    _classList = List<MyClass>();
    _newClass = MyClass();
    selectedCredit = _newClass.credit;
    selectedScoreStr = _gradeList.list.keys.toList()[3];
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          drawer: GpaDrawer(UniqueKey()),
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              "GPA Calculator",
              style: Theme.of(context).textTheme.headline6,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.plus_one,
              size: 48,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            elevation: 1.0,
            onPressed: _addToLessonList,
          ),
          body: _bodyPortraitMode(context, gpa, _classList),
        );
      }
      else{
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          drawer: GpaDrawer(UniqueKey()),
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              "GPA Calculator",
              style: Theme.of(context).textTheme.headline6,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.plus_one,
              size: 48,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            elevation: 1.0,
            onPressed: _addToLessonList,
          ),
          body: _bodyLandscapeMode(context, gpa, _classList),
        );
      }
    });
  }

  Widget _bodyPortraitMode(
      BuildContext context, double gpa, List<MyClass> _classList) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildClassForm(context),
          GPAHeader(gpa: gpa),
          ClassList(UniqueKey(), _classList, _refreshGPA),
        ],
      ),
    );
  }

  Widget _bodyLandscapeMode(
      BuildContext context, double gpa, List<MyClass> _classList) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _buildClassForm(context),
            flex: 1,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                GPAHeader(gpa: gpa),
                ClassList(UniqueKey(), _classList, _refreshGPA),
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _buildClassForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalWidth),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Ders Adı",
                labelStyle: Theme.of(context).textTheme.bodyText2,
                enabledBorder: _getBorderStyle(),
                focusedBorder: _getBorderStyle(),
                errorBorder: _getErrorBorderStyle(),
                focusedErrorBorder: _getErrorBorderStyle(),
              ),
              validator: isStringEmptyValidator,
              onSaved: _selectedClassName,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: borderWidth),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        items: _creditList
                            .map((item) => DropdownMenuItem(
                                child: Text("$item kredi"), value: item))
                            .toList(),
                        onChanged: _selectCredit,
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        value: selectedCredit,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: borderWidth),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: _getScoreList(),
                        onChanged: _selectScore,
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        value: selectedScoreStr,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _getBorderStyle() {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).primaryColor, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  void _selectedClassName(String newValue) {
    _newClass.name = newValue;
  }

  void _selectCredit(value) {
    setState(() {
      selectedCredit = value;
      _newClass.credit = value;
    });
  }

  void _selectScore(value) {
    setState(() {
      selectedScoreStr = value;
      _newClass.scoreStr = value;
      _newClass.score = _gradeList.list[value];
    });
  }

  void _addToLessonList() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      debugPrint(_newClass.toString());

      setState(() {
        _classList.add(MyClass.special(
          name: _newClass.name,
          credit: _newClass.credit,
          score: _newClass.score,
          scoreStr: _newClass.scoreStr,
        ));
      });

      _calculateGPA();
    }
  }

  _getScoreList() {
    List<DropdownMenuItem<String>> menuItems = List();

    for (var item in _gradeList.list.keys) {
      DropdownMenuItem<String> drpItem =
          new DropdownMenuItem(child: Text(item), value: item);
      menuItems.add(drpItem);
    }

    return menuItems;
  }

  String isStringEmptyValidator(String value) {
    return (value == null || value == '')
        ? 'Lütfen ders ismini giriniz.'
        : null;
  }

  _getErrorBorderStyle() {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).errorColor, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  double _calculateGPA() {
    double totalScore = 0;
    double totalCredit = 0;

    if (_classList.length == 0) {
      return 0.0;
    }

    for (var _class in _classList) {
      totalScore += _class.score * _class.credit;
      totalCredit += _class.credit;
    }

    gpa = totalScore / totalCredit;

    debugPrint("$totalScore - $totalCredit");

    return gpa;
  }

  _refreshGPA() {
    setState(() {
      _calculateGPA();
    });
  }
}

class GPAHeader extends StatelessWidget {
  const GPAHeader({
    Key key,
    @required this.gpa,
  }) : super(key: key);

  final double gpa;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Ders Listesi", style: Theme.of(context).textTheme.bodyText1),
            RichText(
              text: TextSpan(
                text: "Ortalama ",
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(
                    text: gpa.toStringAsPrecision(3),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
