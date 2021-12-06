// @dart=2.9

import 'package:flutter/material.dart';
import 'package:note_dapp/constant.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddTaskSheet extends StatefulWidget {
  String title;
  String content;
  bool existed;
  int index;
  AddTaskSheet({this.title, this.content, this.existed, this.index});
  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var _form = GlobalKey<FormState>();

  String title = '';
  String content = '';
  void submitNote(var noteController) {}

  @override
  Widget build(BuildContext context) {
    var noteController = Provider.of<NoteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Note"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: widget.existed ? widget.title : title,
                      style: ktitleStyle.copyWith(),
                      // controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20.0),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title is empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: widget.existed ? widget.content : content,
                      // controller: contentController,
                      style: ktitleStyle.copyWith(fontSize: 20.0),
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20.0),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Content is empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        content = value;
                      },
                      onEditingComplete: () {
                        if (_form.currentState.validate()) {
                          _form.currentState.save();
                          if (widget.existed) {
                            noteController.updateNote(
                                widget.index, title, content);
                          } else {
                            noteController
                                .insertNote(Note(title: title, body: content));
                          }
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (kIsWeb)
                      ElevatedButton(
                          onPressed: () {
                            if (_form.currentState.validate()) {
                              _form.currentState.save();
                              if (widget.existed) {
                                noteController.updateNote(
                                    widget.index, title, content);
                              } else {
                                noteController.insertNote(
                                    Note(title: title, body: content));
                              }
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Submit",
                            style: ktitleStyle,
                          ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
