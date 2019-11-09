import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'model.dart';

class DetailPage extends StatefulWidget {
  final Model model;

  DetailPage({this.model});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _controller = TextEditingController();
  String _title;

  void insertData() async {
    if (_controller.text.isNotEmpty) {
      Model _model = Model(content: _controller.text);
      await DatabaseHelper.insert(_model);
      Navigator.pop(context);
    }
  }

  void updateData() async {
    if (_controller.text.isNotEmpty) {
      Model _model = Model(
        id: widget.model.id,
        content: _controller.text,
      );
      await DatabaseHelper.update(_model);
      Navigator.pop(context);
    }
  }

  void deleteData() async {
    await DatabaseHelper.delete(widget.model.id);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.model != null) {
      _controller.text = widget.model.content;
      _title = "UPDATE OR DELETE DATA";
    } else {
      _title = "INSERT NEW DATA";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: actionButton(),
    );
  }

  List<Widget> actionButton() {
    if (widget.model != null) {
      return [
        FlatButton(
          child: Text("UPDATE"),
          onPressed: updateData,
        ),
        FlatButton(
          child: Text("DELETE"),
          onPressed: deleteData,
        ),
      ];
    } else {
      return [
        FlatButton(
          child: Text("INSERT"),
          onPressed: insertData,
        ),
      ];
    }
  }
}
