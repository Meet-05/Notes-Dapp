// @dart=2.9
import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String operation;
  @HiveField(1)
  String transactionHash;
  @HiveField(2)
  int url;
  Transaction({this.operation, this.transactionHash, this.url = 0});
}
