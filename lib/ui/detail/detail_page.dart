import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../model/model_content.dart';

enum ButtonAction { add, edit, delete, cancel }

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, this.content}) : super(key: key);

  final ModelContent? content;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  final List<ButtonAction> _actions = <ButtonAction>[];
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper _helper = DatabaseHelper.instance;
  late final String _title;

  @override
  void initState() {
    super.initState();
    if (widget.content != null) {
      _controller.text = widget.content!.content;
      _title = 'UPDATE OR DELETE DATA #${widget.content!.id}';
      _actions.addAll([ButtonAction.edit, ButtonAction.delete]);
    } else {
      _title = 'CREATE NEW DATA';
      _actions.addAll([ButtonAction.add]);
    }
    _actions.add(ButtonAction.cancel);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: TextFormField(
        key: _formKey,
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'content...',
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        validator: (String? value) {
          if (value?.isEmpty ?? true) return 'content is required';
        },
      ),
      actions: List<Widget>.generate(
        _actions.length,
        (int index) => TextButton(
          onPressed: () => _onPressedButton(
            index: index,
          ),
          child: Text('${_actions[index]}'.split('.')[1].toUpperCase()),
        ),
      ),
    );
  }

  Future<void> _onPressedButton({required int index}) async {
    if (_actions[index] == ButtonAction.cancel) {
      Navigator.pop(context);
    } else if (_formKey.currentState?.validate() ?? false) {
      switch (_actions[index]) {
        case ButtonAction.add:
          await _helper.insert(
            ModelContent(
              content: _controller.text,
            ),
          );
          break;
        case ButtonAction.edit:
          await _helper.update(
            ModelContent(
              id: widget.content!.id,
              content: _controller.text,
            ),
          );
          break;
        case ButtonAction.delete:
          await _helper.delete(
            widget.content?.id ?? -1,
          );
          break;
        case ButtonAction.cancel:
          break;
      }
      Navigator.pop(context);
    }
  }
}
