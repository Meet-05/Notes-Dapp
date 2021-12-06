import 'package:hive/hive.dart';
import './models/transaction_model.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
