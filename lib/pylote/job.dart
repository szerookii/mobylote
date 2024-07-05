import 'package:http/http.dart' as http;
import 'package:mobylote/pylote/types.dart';
import 'dart:convert';

Future<List<Job>> getJobs() async {
  var url = Uri.parse('https://api-p.pylote.io/jobs');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var decodedJobs = json.decode(response.body) as List;
    var jobs = decodedJobs.map((e) => Job.fromJson(e)).toList();
    jobs.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    return jobs.where((job) => job.aDistanceOuSurPlace.isNotEmpty).toList();
  } else {
    return [];
  }
}