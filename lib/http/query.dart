import 'package:http/http.dart' as http;
import 'dart:convert';
class Query{

  // String SERVER = "http://localhost/DemoHRM1/hs/api/check";

/*
  var response = await http.post('https://json.flutter.su/echo',
                                  body: {'name':'test','num':'10'});
  print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");
*/


  Future<String?> checkUser(String lastName,String firstName,
      String patronymic,String inn) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var uri=Uri.parse("http://localhost/DemoHRM1/hs/api/check");
    final body={
      "lastName": lastName,
      "firstName": firstName,
      "patronymic": patronymic,
      "inn": inn
    };
    var bod = stringToBase64.encode("{ \"lastName\" : \"${lastName}\", \"firstName\" : \"${firstName}\", \"patronymic\" : \"${patronymic}\", \"inn\" : \"${inn}\"}");
    var response = await http.post(uri,
        headers: {
          'Authorization' : 'Basic 0K7QsdC60L7QmtCSOkxFVkk===',
          'Content-Type' : 'application/json',
        },
        body: bod
    );
    // print(response.body);
    var json=jsonDecode(response.body);


    if (response.statusCode == 200) {
      return json['answer'];
    }
    return null;
  }
}