import 'package:quiz_app/constants/apiConstants.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types

// ignore: camel_case_types
class userApi {
  var client = http.Client();

  Future<dynamic> login(String username) async {
    try {
      var url = Uri.parse(apiConstants.baseUrl);
      var headers = {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      };

      var payload = username;

      var response = await client.post(
        url,
        headers: headers,
        body: payload,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}
