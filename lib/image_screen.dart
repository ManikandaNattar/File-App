import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<XFile>? mediaList;
  String? screenName;
  String? folderName;
  @override
  void didChangeDependencies() {
    Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arguments != null) {
      mediaList = arguments['mediaList'];
      screenName = arguments['screen'];
      folderName = arguments['folderName'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Screen"),
        actions: [
          Visibility(
            visible: screenName == "Folder",
            child: TextButton(
              onPressed: () async {
                Navigator.of(context).popAndPushNamed(
                  "/inner-folder",
                  arguments: {
                    "mediaList": mediaList!,
                    "screen": screenName,
                    "folderName": folderName!,
                  },
                );
              },
              child: const Text(
                "SAVE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: mediaList == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 3,
              children: [
                ...mediaList!.map(
                  (e) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 200.0,
                      width: 200.0,
                      child: Image.file(
                        File(e.path),
                        width: 200.0,
                        height: 200.0,
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
    );
  }
}
