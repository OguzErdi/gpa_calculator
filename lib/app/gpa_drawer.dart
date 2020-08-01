import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GpaDrawer extends StatefulWidget {
  List<String> _gradeListType;
  String _selectedGradeType;
  String _oldGradeType;
  double _borderRadius = 10;
  static const String keySelectedGradeType = 'SelectedGradeType';

  GpaDrawer(
    Key key,
  ) : super(key: key) {
    _gradeListType = ["A+", "AA"];
  }

  @override
  _GpaDrawerState createState() => _GpaDrawerState();
}

class _GpaDrawerState extends State<GpaDrawer> {
  @override
  void initState() {
    super.initState();
    _loadGradeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF2a3036),
        child: Column(
          children: <Widget>[
            SizedBox(
              //ekranin 1/8'i kadar bosluk birak
              height: MediaQuery.of(context).size.height / 25,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              color: Theme.of(context).backgroundColor,
              child: Text("Seçenekler",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    //ekranin 1/8'i kadar bosluk birak
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Not Tipi",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius:
                              BorderRadius.circular(widget._borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: widget._gradeListType
                                  .map((value) => DropdownMenuItem(
                                      child: Text("$value"), value: value))
                                  .toList(),
                              onChanged: _changeGradeTypeHandler,
                              dropdownColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              value: widget._selectedGradeType,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    //ekranin 1/8'i kadar bosluk birak
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Container(
                    height: 1,
                    color: Theme.of(context).backgroundColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FlatButton(
                      child: Text("Tüm Dersleri Sil",
                          style: Theme.of(context).textTheme.bodyText1),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(widget._borderRadius),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.red,
                      onPressed: _showWarningDialogDeleteAllClass,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadGradeTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget._selectedGradeType = (prefs.getString(widget._selectedGradeType) ??
          widget._gradeListType[0]);
    });
  }

  _changeGradeTypeHandler(value) {
    _changeGradeTypeValue(value);
    _showWarningDialogChangeGradeType(
      context,
      value,
    );
  }

  _storeGradeType(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GpaDrawer.keySelectedGradeType, value);
  }

  _changeGradeTypeValue(value) {
    widget._oldGradeType = widget._selectedGradeType;
    setState(() {
      widget._selectedGradeType = value;
    });
  }

  _returnOldGradeTypeValue() {
    setState(() {
      widget._selectedGradeType = widget._oldGradeType;
    });
  }

  void _showWarningDialogChangeGradeType(BuildContext context, String value) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Uyarı"),
            content: Text(
              "Not tipini değiştirmeniz tüm ders listesini silecektir. Devam etmek istiyor musunuz?",
            ),
            //kullanıcıdan tamam, kapat, anladım gibi buttonları tanımlaycağın yer.
            actions: <Widget>[
              //theme vermek için, bununla sardık.
              ButtonBarTheme(
                data: ButtonBarThemeData(
                  alignment: MainAxisAlignment.center,
                ),
                //buttonların biraz daha düzenli görünmesi için.
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Evet"),
                      onPressed: () {
                        _storeGradeType(value);
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text("Hayır"),
                      onPressed: () {
                        _returnOldGradeTypeValue();
                        //dialogu kapatma
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _showWarningDialogDeleteAllClass() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Uyarı"),
            content: Text(
              "Tüm ders listesini silecektir. Devam etmek istiyor musunuz?",
            ),
            //kullanıcıdan tamam, kapat, anladım gibi buttonları tanımlaycağın yer.
            actions: <Widget>[
              //theme vermek için, bununla sardık.
              ButtonBarTheme(
                data: ButtonBarThemeData(
                  alignment: MainAxisAlignment.center,
                ),
                //buttonların biraz daha düzenli görünmesi için.
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: 
                            BorderRadius.circular(widget._borderRadius),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.red,
                      child: Text("Evet"),
                      onPressed: () {
                        _removeAllClassList();
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text("Hayır"),
                      onPressed: () {
                        //dialogu kapatma
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _removeAllClassList() {}
}