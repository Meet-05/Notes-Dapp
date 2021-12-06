// @dart=2.9

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';
import '../boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constant.dart';
import '../utils/launch_url_utility.dart';
import '../constant.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transaction History"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ValueListenableBuilder<Box<Transaction>>(
              valueListenable: Boxes.getTransactions().listenable(),
              builder: (context, box, _) {
                List<Transaction> transctionList =
                    box.values.toList().cast<Transaction>().reversed.toList();
                return ListView.builder(
                    itemCount: transctionList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 12.0, bottom: 8.0),
                          decoration: const BoxDecoration(
                              color: Color(0xFF1D2022),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  transctionList[index].operation,
                                  style: ktitleStyle.copyWith(fontSize: 23),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                transctionList[index].transactionHash,
                                style: ktitleStyle,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Utils.openLink(
                                        url:
                                            "https://ropsten.etherscan.io/tx/${transctionList[index].transactionHash}");
                                  },
                                  child: Text(
                                    "View More 🔗",
                                    style: ktitleStyle,
                                  ))
                            ],
                          ));
                    });
              }),
        ));
  }
}
