import 'package:flutter/material.dart';
import 'package:mobylote/notifications/notification_service.dart';
import 'package:mobylote/views/home/home.dart';
import 'package:mobylote/views/login/ask_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const mobyloteBackgroundRefresh = "fr.szeroki.mobylote.backgroundRefresh";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("$task started. inputData = $inputData");

    switch (task) {
      case mobyloteBackgroundRefresh:
        await NotificationService().displayNotification(
          "Mobylote",
          "Hello from background refresh",
        );
        break;
    }
    
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const MobyloteApp());
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

    Workmanager().registerPeriodicTask(
      mobyloteBackgroundRefresh,
      mobyloteBackgroundRefresh,
      tag: mobyloteBackgroundRefresh,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 5),
      existingWorkPolicy: ExistingWorkPolicy.append,
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(seconds: 5),
      outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      inputData: const <String, dynamic>{},
    );

    print("Mobylote started");
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
