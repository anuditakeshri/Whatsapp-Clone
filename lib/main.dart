import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Screens/dashboard_screen.dart';
import 'package:whatsapp_clone/Screens/login_screen.dart';
import 'package:whatsapp_clone/Screens/naming_screen.dart';
import 'package:whatsapp_clone/Screens/terms_conditions.dart';

import 'Screens/loading_screen.dart';

List<CameraDescription>? cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/tc': (context) => TermsConditions(),
        '/login': (context) => LoginScreen(),
        // '/otp': (context) => OtpVerify()
        '/profile': (context) => ProfileScreen(),
        '/dashboard': (context) => DashboardScreen(cameras),
        // '/chat' : (context) => ChatScreen()
      },
      theme: ThemeData.light(),
    );
  }
}
