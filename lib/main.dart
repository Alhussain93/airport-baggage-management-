import 'package:flutter/material.dart';
import 'package:luggage_tracking_app/provider/admin_provider.dart';
import 'package:provider/provider.dart';

import 'AdminView/missing_luggage.dart';
import 'UserView/splash_screen.dart';
import 'UserView/tracking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AdminProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Luggage Handling',
          theme: ThemeData(),
          home:  SplashScreen(),
        ));
  }
}
