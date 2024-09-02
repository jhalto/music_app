import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/home_page.dart';
import 'package:music_app/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Music',

     theme: ThemeData.light(

     ),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
