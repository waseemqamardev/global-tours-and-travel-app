import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'splash/Splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
      ,
      title: 'Flutter Travel UI',
      theme: ThemeData(

        primaryColor: Color(0xFF3EBACE),
        scaffoldBackgroundColor: Color(0xFFF3F5F7), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFD8ECF1)),
      ),
      home:Splash(),
    );
  }
}


