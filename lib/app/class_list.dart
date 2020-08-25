import 'package:flutter/material.dart';
import 'package:gpa_calculator/model/my_class.dart';

class ClassList extends StatefulWidget {
  List<MyClass> _classList;
  var _refreshGPA;
  var _saveClassList;
  var _copyClassToForm;

  ClassList(
    Key key,
    this._classList,
    this._refreshGPA,
    this._saveClassList,
    this._copyClassToForm,
  ) : super(key: key);

  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    if (widget._classList != null && widget._classList.length > 0) {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget._classList.length,
          itemBuilder: (context, index) {
            final item = widget._classList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  DissBackground(),
                  _buildDissForeGround(item, index, context),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildDissForeGround(MyClass item, int index, BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Dismissible(
        //rounded olduğu için, animasyonda köşeler sivri kalıyor. Bu yüzden stack kullanıldı.
        // background: Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10), color: Colors.red),
        // ),
        key: UniqueKey(),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            debugPrint("edit");
            _editClassEvent(item, index);
          } else {
            debugPrint("remove");
            _removeClassEvent(item, index);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
          ),
          child: ListTile(
            leading: Icon(
              Icons.done_outline,
              size: 35,
              color: Theme.of(context).accentColor,
            ),
            title: Text(item.name),
            subtitle: Text(
                "Kredi Sayısı: ${item.credit} | Harf Notu: ${item.scoreStr}"),
            trailing: Icon(Icons.swap_horiz),
          ),
        ),
      ),
    );
  }

  _removeClassEvent(item, index) {
    // Remove the item from the data source.
    _removeClass(index);

    // Show a snackbar. This snackbar could also contain "Undo" actions.
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.name} Dersi silindi."),
      ),
    );
  }

  void _removeClass(index) {
    setState(() {
      debugPrint("silindi.");
      widget._classList.removeAt(index);
      widget._saveClassList();
      widget._refreshGPA();
    });
  }

  _editClassEvent(MyClass item, index) {
    widget._copyClassToForm(item, index);
    _removeClass(index);
    // Show a snackbar. This snackbar could also contain "Undo" actions.
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.name} Dersi düzenlenmek için silindi. Düzenleyip tekrar ekleyebilirsiniz."),
      ),
    );
  }
}

class DissBackground extends StatelessWidget {
  const DissBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Theme.of(context).accentColor,
              ),
              child: Container(
                width: 80,
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.red,
              ),
              child: Container(
                width: 80,
                child: Icon(Icons.delete),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
