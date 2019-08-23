import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db_helper.dart';
import 'package:flutter_sqlite/model.dart';

class Detail extends StatefulWidget {
  final User user;

  Detail({this.user});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool create;
  User _user;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  createUser() async {
    // if name and email not empty
    if (controllerName.text.isNotEmpty && controllerEmail.text.isNotEmpty) {
      // set user name and email
      _user = User(
        name: controllerName.text,
        email: controllerEmail.text,
      );
      // waiting for insert data user
      await DBHelper.insertUser(_user);
      // back to home page
      Navigator.pop(context);
    }
  }

  updateUser() async {
    // if name and email not empty
    if (controllerName.text.isNotEmpty && controllerEmail.text.isNotEmpty) {
      // set user id, name, and email
      _user = User(
        id: widget.user.id,
        name: controllerName.text,
        email: controllerEmail.text,
      );
      // waiting for update data user
      await DBHelper.updateUser(_user);
      // back to home page
      Navigator.pop(context);
    }
  }

  deleteUser() async {
    // waiting for delete data user
    await DBHelper.deleteUser(widget.user.id);
    // back to home page
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // on initialize state check user from home
    if (widget.user != null) {
      // if user not null set create false, name controller, and email controller
      create = false;
      controllerName.text = widget.user.name;
      controllerEmail.text = widget.user.email;
    } else {
      // if user is null set create true
      create = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: controllerName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              alignLabelWithHint: true,
            ),
          ),
          TextField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // if this detail for create new data show just button add
        create
            ? FlatButton(
                onPressed: createUser,
                child: Text('ADD'),
              )
            : null,
        // if this detail for edit and delete data show just button edit and delete
        create
            ? null
            : FlatButton(
                onPressed: updateUser,
                child: Text('UPDATE'),
              ),
        create
            ? null
            : FlatButton(
                onPressed: deleteUser,
                child: Text('DELETE'),
              ),
      ],
    );
  }
}
