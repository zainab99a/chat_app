import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
//حتى اكدر استخدم الفاير بيز نسوي امبورت
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //لتهيئه التطبيق و الفايربيز
 await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //اول ما يفتح التطبيق تظهر welcomscreen
     initialRoute: _auth.currentUser!=null? 'chat_screen':'welcome_screen',
      routes: {
        'welcome_screen':(context)=>WelcomeScreen(),
        'signin_screen':(context)=>SigninScreen(),
        'registeration_screen':(context)=>RegistrationScreen(),
        'chat_screen':(context)=>ChatScreen(),
      },
    );
  }
}

