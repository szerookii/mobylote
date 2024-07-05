import 'package:http/http.dart' as http;
import 'package:mobylote/pylote/types.dart';
import 'dart:convert';

Future<Profile?> getProfile(String id) async {
  var url = Uri.parse('https://api-p.pylote.io/freelance/profile/$id');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return Profile.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<bool> setAvailability(String id, bool available, String availabilityDate) async {
  var url = Uri.parse('https://api-p.pylote.io/availability/$id');
  var response = await http.put(url, body: {
    "available": available.toString(),
    "availabilityDate": availabilityDate
  });
  
  return response.statusCode == 200;
}