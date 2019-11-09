import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'detail.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> _listModel = List();

  void readAllData() async {
    List<Model> models = await DatabaseHelper.readAll();
    setState(() {
      if (models != null) {
        _listModel = models;
      } else {
        _listModel = List();
      }
    });
  }

  void openDetail([Model model]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailPage(
          model: model,
        );
      },
    ).then((_) {
      readAllData();
    });
  }

  @override
  void initState() {
    readAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eudeka! Flutter Basic"),
      ),
      body: ListView.separated(
        itemCount: _listModel.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_listModel[index].content),
            onTap: () {
              openDetail(_listModel[index]);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: openDetail,
      ),
    );
  }
}
