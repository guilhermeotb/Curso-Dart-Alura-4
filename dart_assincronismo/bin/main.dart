// dart run bin/main.dart
import 'package:http/http.dart';
import 'dart:convert';

void main(){
//requestData();
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
 print(futureResponse);
 futureResponse.then((Response response) {
print(response);
print(response.body);

List<dynamic> listAccounts = json.decode(response.body);
Map<String, dynamic> mapCarla = listAccounts.firstWhere((element) => element["name"] == "Carla",);

print(mapCarla["balance"]);

 },);

 print("Última coisa a acontecer na função.");

}

Future<List<dynamic>> resquestDataAsync() async {

  String url =
   "https://gist.githubusercontent.com/guilhermeotb/b5e5988083befbf76bfc7e34c6f518d1/raw/8eb9c4615a551aa5f6eb119cec1a93c781759f5e/accounts.json";
  Response response = await get(Uri.parse(url));
  
  return json.decode(response.body);

}


sendDataAsync(Map<String, dynamic> mapAccount) async{
  List<dynamic> listAccounts = await resquestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  print(content);
  print(json.encode(listAccounts.last));
}

  
