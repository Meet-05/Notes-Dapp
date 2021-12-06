// @dart=2.9

import '../models/transaction_model.dart';
import '../boxes.dart';

Future addProduct(String operation, String hash) async {
  final transaction = Transaction()
    ..operation = operation
    ..transactionHash = hash;
  final box = Boxes.getTransactions();
  box.add(transaction);
}
