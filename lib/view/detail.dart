import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/model_content.dart';

class DetailPage extends StatefulWidget {
  final ModelContent content;

  DetailPage({this.content});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _title;
  String _contentText;
  List<String> _actions = ["CANCEL"];
  bool _first = true;

  void _onPressedButton({@required int index}) async {
    _first = false;
    setState(() {});
    if (_globalKey.currentState.validate()) {
      switch (_actions[index]) {
        case "ADD":
          await DatabaseHelper.insert(
            ModelContent(
              content: _contentText,
            ),
          );
          break;
        case "EDIT":
          await DatabaseHelper.update(
            ModelContent(
              id: widget.content.id,
              content: _contentText,
            ),
          );
          break;
        case "DELETE":
          await DatabaseHelper.delete(
            widget.content.id,
          );
          break;
      }
      Navigator.pop(context);
    } else if (_actions[index] == "CANCEL") {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (widget.content != null) {
      _contentText = widget.content.content;
      _title = "UPDATE OR DELETE DATA";
      _actions.addAll(["EDIT", "DELETE"]);
    } else {
      _title = "INSERT NEW DATA";
      _actions.addAll(["ADD"]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Form(
        key: _globalKey,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          onChanged: (String value) {
            _contentText = value;
          },
          validator: (String value) {
            return value.isEmpty ? "required" : null;
          },
        ),
        autovalidate: !_first,
      ),
      actions: actionButton(),
    );
  }

  List<Widget> actionButton() {
    return List<Widget>.generate(
      _actions.length,
      (int index) {
        return FlatButton(
          onPressed: () {
            _onPressedButton(
              index: index,
            );
          },
          child: Text(_actions[index]),
        );
      },
    );
  }
}
