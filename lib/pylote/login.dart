import 'dart:convert';
import 'package:http/http.dart' as http;

// setLoginCode sends a POST request to the API to request a login code sent to the user's email.
Future<bool> setLoginCode(String email, bool resend) async {
  var url = Uri.parse('https://api-p.pylote.io/freelance/set_login_code');
  var response = await http.post(
    url,
    body: {"mail": email, "resend": resend.toString()},
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'newUser') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

// checkCode sends a POST request to the API to check if the code entered by the user is valid and returns the user's ID.
Future<String?> checkCode(String email, String code) async {
  var url = Uri.parse('https://api-p.pylote.io/freelance/check_code');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"mail": email, "code": code}),
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody['check'] == true && responseBody['id'] != null) {
      return responseBody['id'];
    }
  }

  return null;
}