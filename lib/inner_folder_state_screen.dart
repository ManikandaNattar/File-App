import 'dart:io';

import 'package:file_app_icanio/show_bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InnerFolderStateScreen extends StatefulWidget {
  const InnerFolderStateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InnerFolderStateScreen> createState() => _InnerFolderStateScreenState();
}

class _InnerFolderStateScreenState extends State<InnerFolderStateScreen> {
  List<XFile>? imageList;
  String? folderName;

  @override
  void didChangeDependencies() {
    Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arguments != null) {
      imageList = arguments['mediaList'];
      folderName = arguments['folderName'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed("/folder");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(folderName!),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     onPressed: () {
          //       _showMyDialog();
          //     },
          //   ),
          // ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.file_copy,
          ),
          onPressed: () {
            showBottomMenu(
              context,
              "Folder",
              folderName!,
            );
          },
        ),
        body: imageList == null
            ? const Center(
                child: Text("No Image Available"),
              )
            : GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 200.0,
                    width: 200.0,
                    child: Image.file(
                      File(imageList![index].path),
                      width: 200.0,
                      height: 200.0,
                    ),
                  );
                },
                itemCount: imageList!.length,
              ),
      ),
    );
  }
}
