// dart run bin/main.dart
import 'dart:async';
import 'package:dart_assincronismo/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

StreamController<String> streamController = StreamController<String>();

void main(){

StreamSubscription streamSubscription = streamController.stream.listen((String info) {
  print(info);
  });

resquestData();
resquestDataAsync();
sendDataAsync({
  "id": "NEW001",
  "name":"Flutter",
  "lastname":"Dart",
  "balance": 5000,
  });


}

resquestData(){
  String url = "https://gist.githubusercontent.com/guilhermeotb/b5e5988083befbf76bfc7e34c6f518d1/raw/8eb9c4615a551aa5f6eb119cec1a93c781759f5e/accounts.json";
 Future<Response> futureResponse = get(Uri.parse(url));
 
 futureResponse.then((Response response) {

  streamController.add("${DateTime.now()} | Requisição de leitura(usando then).");






 },);


}

Future<List<dynamic>> resquestDataAsync() async {

  String url =
   "https://gist.githubusercontent.com/guilhermeotb/b5e5988083befbf76bfc7e34c6f518d1/raw/8eb9c4615a551aa5f6eb119cec1a93c781759f5e/accounts.json";
  Response response = await get(Uri.parse(url));
  
 streamController.add("${DateTime.now()} | Requisição de leitura.");

  return json.decode(response.body);

}


sendDataAsync(Map<String, dynamic> mapAccount) async{
  List<dynamic> listAccounts = await resquestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  
  String url =
   "https://api.github.com/gists/b5e5988083befbf76bfc7e34c6f518d1";

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
    streamController.add("${DateTime.now()} | Requisição de adição bem sucedida (${mapAccount["name"]}).");
   } else {
    streamController.add("${DateTime.now()} | Requisição falhou.");
   }

}

  
