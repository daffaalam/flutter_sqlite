import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/model_content.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelContent> _listModel;

  void _readAllData() async {
    _listModel = await DatabaseHelper.readAll();
    setState(() {});
  }

  void _openDetail([ModelContent content]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailPage(
          content: content,
        );
      },
      barrierDismissible: false,
    ).then((_) {
      _readAllData();
    });
  }

  @override
  void initState() {
    _readAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eudeka! Flutter Basic"),
      ),
      body: ListView.builder(
        itemCount: _listModel?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          ModelContent _modelContent = _listModel[index];
          return Card(
            child: ListTile(
              title: Text(_modelContent.content),
              onTap: () {
                _openDetail(_modelContent);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _openDetail,
      ),
    );
  }
}
