import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobylote/pylote/types.dart';

Future<String?> getRecruiterThumbail(String name, {String? size = 'small'}) async {
  var url = Uri.parse('https://api-p.pylote.io/recruiter/?displayMissions=false');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    for (var recruiter in responseBody) {
      if (recruiter['Name'] == name) {
        if (size == null) {
          return recruiter['thumbnails']['full']['url'];
        } else {
          return recruiter['thumbnails'][size]['url'];
        }
      }
    }
  }

  return null;
}

Future<void> bulkAddRecruiterThumbnails(List<Job> jobs, {String size = 'small'}) async {
  var url = Uri.parse('https://api-p.pylote.io/recruiter/?displayMissions=false');
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  
  for (var job in jobs) {
    final String recruiterName = job.plateforme;
    if (recruiterName.isNotEmpty) {
      for (var recruiter in responseBody) {
        if (recruiter['Name'] == recruiterName) {
          job.recruiterThumbnail = recruiter["Logo"][0]["thumbnails"][size]["url"];
          break;
        }
      }
    } else {
      job.recruiterThumbnail = null;
    }
  }
}