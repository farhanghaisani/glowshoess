import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:glowshoess.id/core.dart';
import 'depedency_injection.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final fcmService = FCMService();
  fcmService.init();

  // Initialize the Dependency Injection
  DependencyInjection.init();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getX.GetMaterialApp(
      title: 'Klinik Shoes Project',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: AppRoutes
          .getHomeRoute(), // Set the initial route based on your routing setup
      getPages: AppRoutes.routes, // Set up your page routes from AppRoutes
    );
  }
}
