import 'dart:convert';

import 'package:get/get.dart';
import 'package:quiz_app/constants/apiConstants.dart';
import 'package:quiz_app/models/userModel.dart';
import 'package:quiz_app/services/api.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController{

  var client = http.Client();
  Future login(String username) async{

    try{
    final url = Uri.parse(apiConstants.baseUrl);
    final headers = {
      'Content-Type': 'aplication/json',
      'Cache-Control': 'no-cache',
    };  

        var response = await client.get(url,headers: headers);

        if(response.statusCode == 200){
          print (response.body);
          return json.decode(response.body);

        }else {
          print("Error");
        }
    }catch(e){
      print(e);
    }
  
    return false;
  }

}