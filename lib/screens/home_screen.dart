// @dart=2.9
// import 'package:flutter/material.dart';
// import 'package:note_dapp/models/note_model_copy.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final noteController = Provider.of<NoteController>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             TextButton(
//               onPressed: () async {
//                 await noteController
//                     .insertNote(Note(body: "title one", title: "body one"));
//               },
//               child: const Text("insert"),
//             ),
//             TextButton(
//                 onPressed: () async {
//                   await noteController.updateNote(
//                       1, "title changed and updated", "body updated");
//                 },
//                 child: const Text("update")),
//             TextButton(
//               onPressed: () async {
//                 await noteController.deletetNote(0);
//               },
//               child: const Text("delete"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await noteController.getNote();
//               },
//               child: const Text("read"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:note_dapp/widgets/loading_screen.dart';
import '../widgets/notes_list.dart';
import '../widgets/add_task_sheet.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../widgets/refresh_widget.dart';
import './transactions_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var noteController = Provider.of<NoteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.history_outlined,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TransactionScreen()));
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          if (kIsWeb)
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: 30.0,
              ),
              onPressed: () {
                noteController.getNote();
              },
            ),
        ],
      ),
      body: RefreshWidget(
          onRefresh: () async {
            noteController.getNote();
          },
          child: NotesList()),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTaskSheet(
                          existed: false,
                        )));
          }),
    );
  }
}
