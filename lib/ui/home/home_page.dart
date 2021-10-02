import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../model/model_content.dart';
import '../detail/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _helper = DatabaseHelper.instance;
  List<ModelContent> _listModel = <ModelContent>[];

  @override
  void initState() {
    super.initState();
    _readAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eudeka! Flutter SQLite'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openDetail,
      ),
    );
  }

  Future<void> _readAllData() async {
    _listModel = await _helper.readAll();
    setState(() {});
  }

  Future<void> _openDetail([ModelContent? content]) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => DetailPage(
        content: content,
      ),
      barrierDismissible: false,
    );
    await _readAllData();
  }

  Widget _body() {
    if (_listModel.isEmpty) {
      return const Center(
        child: Text('There is no data to display'),
      );
    } else {
      return ListView.builder(
        itemCount: _listModel.length,
        itemBuilder: (BuildContext context, int index) {
          ModelContent content = _listModel[index];
          return Card(
            child: ListTile(
              title: Text(content.content),
              onTap: () => _openDetail(content),
            ),
          );
        },
      );
    }
  }
}
