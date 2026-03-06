import 'dart:async';
import 'package:dart_assincronismo/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AccountService {  

  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url =
   "https://api.github.com/gists/b5e5988083befbf76bfc7e34c6f518d1";


  Future<List<dynamic>> resquestDataAsync() async {

  Response response = await get(Uri.parse(url));
  
 _streamController.add("${DateTime.now()} | Requisição de leitura.");

  return json.decode(response.body);

}

sendDataAsync(Map<String, dynamic> mapAccount) async{
  List<dynamic> listAccounts = await resquestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  

   Response response = await post(
    Uri.parse(url),
    headers: {"Authorization" : "Bearer $githubApiKey"},
    body: json.encode({
    "description" : "account.json",
    "public" : true,
    "files" : {
      "accounts.json" : { "content" : content,}
    }
    
    }));

   if(response.statusCode.toString()[0] == "2"){
    _streamController.add("${DateTime.now()} | Requisição de adição bem sucedida (${mapAccount["name"]}).");
   } else {
    _streamController.add("${DateTime.now()} | Requisição falhou.");
   }

}

}