import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowshoess/core.dart';
// import 'package:glowshoess/module/speaker/view/speaker_notif_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final fcmService = FCMService();
  fcmService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'glowshoess',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // home: SpeakerPageView()
        initialRoute: AppRoutes.getHomeRoute(),
        getPages: AppRoutes.routes);
  }
}
