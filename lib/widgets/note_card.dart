// @dart=2.9
import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/add_task_sheet.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';

const double ContainerWidth = 380;

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final int id;
  Function deleteNote;
  NoteCard({this.title, this.content, this.id, this.deleteNote});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      background: Container(
        margin: EdgeInsets.only(top: 30.0, left: 2.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 50.0,
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        deleteNote();
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to permanantely delete this?'),
                  actions: [
                    FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        }),
                    FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        }),
                  ],
                ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0, left: 10.0),
            padding: EdgeInsets.all(12.0),
            width: ContainerWidth,
            decoration: BoxDecoration(
              color: Color(0xFFBC8CF2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTaskSheet(
                              existed: true,
                              title: title,
                              content: content,
                              index: id,
                            )));
              },
              child: Text(
                title,
                style: ktitleStyle.copyWith(fontSize: 25),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(left: 10.0),
            width: ContainerWidth,
            decoration: BoxDecoration(
              color: Color(0xFFffabe1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(content,
                  style: ktitleStyle.copyWith(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
