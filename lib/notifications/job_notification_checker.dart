import 'dart:developer';

import 'package:mobylote/notifications/notification_service.dart';
import 'package:mobylote/pylote/job.dart';
import 'package:mobylote/pylote/types.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkJobNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String userId = prefs.getString('id') ?? '';

  if(userId.isEmpty) {
    log('No user id found, skipping job notification');
    return;
  }

  // TODO: check if it's last day user is available eheheh

  List<Job> jobs = await getJobs();
  
  if(jobs.isEmpty) {
    log('No jobs found, skipping job notification');
    return;
  }

  log('Found ${jobs.length} jobs');

  Job job = jobs[0];
  final String lastFoundJobId = prefs.getString('lastFoundJobId') ?? '';
  if(job.id == lastFoundJobId) {
    log('Job already found, skipping job notification');
    return;
  }

  prefs.setString('lastFoundJobId', job.id);
  
  await NotificationService().displayNotification(
    job.title,
    "📍 Lieu: ${job.city} ${job.tjm.isNotEmpty ? '| 💰 TJM: ${job.tjm}' : ''} | 🛰️ Type: ${job.aDistanceOuSurPlace}",
    payload: job.url,
  );
}