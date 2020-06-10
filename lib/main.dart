import 'package:flutter/material.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/views/home.dart';
import 'package:quizapp/views/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedin = false;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
  }
  checkUserLoggedInStatus()async{
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedin = value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:(_isLoggedin ?? false)? Home(): SignIn(),
    );
  }
}
