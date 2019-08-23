import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db_helper.dart';
import 'package:flutter_sqlite/detail.dart';
import 'package:flutter_sqlite/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initialize list of user
  List<User> listUser = List();

  readUsers() async {
    // waiting for read all users at database
    List<User> users = await DBHelper.readUsers();
    setState(() {
      // set all users to list of user
      listUser = users != null ? users : List();
    });
  }

  checkFirst() async {
    // waiting for a second then read users
    return Timer(Duration(seconds: 1), readUsers);
  }

  @override
  void initState() {
    super.initState();
    // checking users for the first time
    checkFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${listUser.length} datas'),
      ),
      body: ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(listUser[index].name),
            subtitle: Text(listUser[index].email),
            onTap: () {
              // show the dialog for edit or delete user
              showDialog(
                context: context,
                builder: (context) {
                  return Detail(
                    user: User(
                      id: listUser[index].id,
                      name: listUser[index].name,
                      email: listUser[index].email,
                    ),
                  );
                },
              ).then((_) {
                // after dialog is showing check users again
                readUsers();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // show the dialog for add new user
          showDialog(
            context: context,
            builder: (context) {
              return Detail();
            },
          ).then((_) {
            // after dialog is showing check users again
            readUsers();
          });
        },
      ),
    );
  }
}
