import 'package:flutter/material.dart';
import 'package:fpm/views/login.dart';
import 'package:fpm/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller 12',
      initialRoute: '/SplashApp',
      routes: <String, WidgetBuilder>{
          // '/kupi' : (BuildContext context) => Kupi(),
          // '/login' : (BuildContext context) => SignInKupi(),
          // '/home' : (BuildContext context) => KupiMenu(),
          '/SplashApp' : (BuildContext context) => Splash(),
          '/Login' : (BuildContext context) => Login(),
          // '/tutorial': (BuildContext context) => Tutorial(),
      },
    );
  }
}
