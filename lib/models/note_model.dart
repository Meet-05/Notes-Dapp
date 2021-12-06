// @dart=2.9
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import '../controllers/transaction_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NoteController extends ChangeNotifier {
  bool isLoading = false;
  List<Note> notes = [];
  final String _netWorkUrl = dotenv.env['NETWORKURL'];

  final String _netWorkSoketUrl = dotenv.env['NETWORKSOCKETURL'];

  final String walletPrivatKey = dotenv.env['WALLETPRIVATEKEY'];

  String ropostenContractAddress = dotenv.env['CONTRACTADDRESS'];

  Web3Client _client;

  Credentials _credentials;
  EthereumAddress walletAddress;
  EthereumAddress _contractAddress;
  DeployedContract _contract;
  ContractFunction _siteName;

  String mainAddrress = "";
  String mainSiteName = "";

  NoteController() {
    setUp();
  }

  String _abiCode = "";

  Future<void> setUp() async {
    _client = Web3Client(_netWorkUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_netWorkSoketUrl).cast<String>();
    });
    await getWalletAddress();
    await geAbi();
    await getNote();
  }

  Future<void> getWalletAddress() async {
    _credentials = await _client.credentialsFromPrivateKey(walletPrivatKey);

    walletAddress = await _credentials.extractAddress();

    mainAddrress = walletAddress.toString();
    print(mainAddrress);

    notifyListeners();
  }
  //Get The ABI

  Future<void> geAbi() async {
    String abiFile = await rootBundle.loadString("assets/abi.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi);
    print(_abiCode);
    _contractAddress = EthereumAddress.fromHex(ropostenContractAddress);
    print("abi done");
  }

  //Get Deploy Contract
  Future<dynamic> getDeployedContract() async {
    final contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "NOTES"), _contractAddress);
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    // EthPrivateKey credentials = EthPrivateKey.fromHex(
    //     "4ad28e280ce1223e914af8549e86374d3ad9e774f71599b2862e42b6e5824569");
    DeployedContract contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    print("before call");
    final String result = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );
    print("aftercall the trransaction hash is  ${result}");
    addProduct(functionName, result);
    return result;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    print("funciton ${functionName} called");
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await _client.call(
        contract: contract, function: ethFunction, params: args);
    return result[0];
  }

  Future<void> insertNote(Note note) async {
    isLoading = !isLoading;
    notifyListeners();
    String result = await submit('addNote', [note.title, note.body]);
    // await Future.delayed(Duration(seconds: 12));
    await getNote();
  }

  Future<void> deletetNote(int index) async {
    isLoading = !isLoading;
    notifyListeners();
    await submit('deleteNote', [BigInt.from(index)]);
    // await Future.delayed(Duration(seconds: 12));
    await getNote();
  }

  Future<void> updateNote(int index, String title, String note) async {
    isLoading = !isLoading;
    notifyListeners();
    await submit('updateNote', [BigInt.from(index), title, note]);
    // await Future.delayed(Duration(seconds: 12));
    await getNote();
  }

  Future<void> getNote() async {
    final result = await query('getNotes', []);
    print(result);
    notes.clear();
    result.forEach((element) {
      notes.add(Note(title: element[0], body: element[1]));
    });
    isLoading = false;
    notifyListeners();
  }
}

class Note {
  String title;
  String body;
  Note({this.title, this.body});
}
