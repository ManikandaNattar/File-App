import 'dart:io';

import 'package:file_app_icanio/show_bottom_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "File App",
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showBottomMenu(context, "Home", "Folder");
            },
            child: const Text(
              "File Upload",
            ),
          ),
        ),
      ),
    );
  }
}
