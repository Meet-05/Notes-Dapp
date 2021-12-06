// @dart=2.9
import 'package:flutter/material.dart';
import 'package:note_dapp/models/note_model.dart';
import 'package:note_dapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/transaction_model.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init('${directory.path}');
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteController(),
      child: MaterialApp(
        title: 'Note Taking DApp',
        theme: ThemeData.dark(),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
