import 'package:emrergency/DashboardScreen.dart';
import 'package:emrergency/screens/Authentication/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/HomeScreens/SignalorScreen/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: 'AIzaSyAbWX29QThWWjDj_czUDsFha-B4_Vk_vos',
    appId: '1:809331144142:android:dadb2c01326d15c571679f',
    messagingSenderId: '809331144142',
    projectId:'emergency-2360b',storageBucket:
    'emergency-2360b.appspot.com',authDomain: 'emergency-2360b.firebaseapp.com',databaseURL: 'https://emergency-2360b-default-rtdb.firebaseio.com'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
