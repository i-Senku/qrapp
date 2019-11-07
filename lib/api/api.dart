import 'dart:convert';

import 'package:http/http.dart' as http;

class MyApi{

  static Future<bool> postData({String eventID,String isim,String soyad,String mail,String telefon})async{
    var url = "https://re7ez581xk.execute-api.eu-west-1.amazonaws.com/dev/meetup/createUser/$eventID";
    
    Map<String,dynamic> data = {
      "firstName" : "$isim",
      "lastName": "$soyad",
      "email": "$mail",
      "phone": "$telefon"
    };

    var response = await http.post(url,body: jsonEncode(data));
    print("Response : ${jsonDecode(response.body)}");

    return response.statusCode == 200 ? true : false;

  }

}