import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var noteController = Provider.of<NoteController>(context);
    final notes = noteController.notes;

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) => NoteCard(
          title: notes[index].title,
          content: notes[index].body,
          id: index,
          deleteNote: () {
            noteController.deletetNote(index);
          }),
    );
  }
}
