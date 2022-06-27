import 'package:file_app_icanio/folder_screen.dart';
import 'package:file_app_icanio/home_screen.dart';
import 'package:file_app_icanio/image_screen.dart';
import 'package:file_app_icanio/inner_folder_state_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/image': (ctx) => const ImageScreen(),
        '/folder': (ctx) => const FolderScreen(),
        '/inner-folder': (context) => const InnerFolderStateScreen(),
      },
    );
  }
}
