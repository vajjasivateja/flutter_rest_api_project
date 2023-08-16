import 'package:flutter/material.dart';
import 'package:flutter_rest_api_project/sign_up_screen.dart';
import 'package:flutter_rest_api_project/upload_image_screen.dart';

import 'example_four.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: UploadImageScreen(),
    );
  }
}

