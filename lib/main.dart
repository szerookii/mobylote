import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:mobylote/notifications/job_notification_checker.dart';
import 'package:mobylote/notifications/notification_service.dart';
import 'package:mobylote/views/home/home.dart';
import 'package:mobylote/views/login/ask_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    log("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  
  await checkJobNotification();
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  initializeDateFormatting('fr_FR', null);

  runApp(const MobyloteApp());

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MobyloteApp extends StatefulWidget {
  const MobyloteApp({super.key});

  @override
  State<MobyloteApp> createState() => _MobyloteAppState();
}

class _MobyloteAppState extends State<MobyloteApp> {
  Future<String?> _checkStoredId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  @override
  void initState() {
    super.initState();
    initBackgroundFetch();
  }

  Future<void> initBackgroundFetch() async {
    int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
    ), (String taskId) async {
      log("[BackgroundFetch] Event received $taskId");
      await checkJobNotification();
      BackgroundFetch.finish(taskId);
    }, (String taskId) async { 
      log("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    log('[BackgroundFetch] configure success: $status');

    status = await BackgroundFetch.start();
    log('[BackgroundFetch] start success: $status');

     if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobylote',
      theme: ThemeData.dark(),
      home: FutureBuilder<String?>(
        future: _checkStoredId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasError) {
            return const AskCodePage();
          } else if (snapshot.hasData && snapshot.data != null) {
            return HomePage(id: snapshot.data!);
          } else {
            return const AskCodePage();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
