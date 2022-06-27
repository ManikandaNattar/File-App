import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  callFolderCreationMethod(String folderInAppDocDir) async {
    // ignore: unused_local_variable
    String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
    debugPrint(actualFileName);
    setState(() {});
  }

  final folderController = TextEditingController();
  String? nameOfFolder;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              Text(
                'ADD FOLDER',
                textAlign: TextAlign.left,
              ),
              Text(
                'Type a folder name to add',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: folderController,
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Enter folder name'),
                onChanged: (val) {
                  setState(() {
                    nameOfFolder = folderController.text;
                    debugPrint(nameOfFolder);
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (nameOfFolder != null) {
                  await callFolderCreationMethod(nameOfFolder!);
                  getDir();
                  setState(() {
                    folderController.clear();
                    nameOfFolder = null;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<FileSystemEntity>? _folders;
  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/';
    final myDir = Directory(pdfDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
    debugPrint(_folders.toString());
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure to delete this folder?',
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async {
                await _folders![index].delete();
                getDir();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _folders = [];
    getDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed("/home");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Folder Info"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showMyDialog();
              },
            ),
          ],
        ),
        body: GridView.builder(
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
            return Material(
              elevation: 6.0,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<FileStat>(
                            future: getFileType(_folders![index]),
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData) {
                                FileStat? f = snapshot.data;
                                debugPrint("file.stat() ${f!.type}");

                                if (f.type.toString().contains("file")) {
                                  return const Icon(
                                    Icons.file_copy_outlined,
                                    size: 100,
                                    color: Colors.orange,
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        "/inner-folder",
                                        arguments: {
                                          "folderName": _folders![index]
                                              .path
                                              .split('/')
                                              .last,
                                        },
                                      );

                                      /* final myDir = new Directory(_folders[index].path);
    
                                            var    _folders_list = myDir.listSync(recursive: true, followLinks: false);
    
                                            for(int k=0;k<_folders_list.length;k++)
                                            {
                                              var config = File(_folders_list[k].path);
                                              debugPrint("IsFile ${config is File}");
                                            }
                                            debugPrint(_folders_list);*/
                                    },
                                    child: const Icon(
                                      Icons.folder,
                                      size: 100,
                                      color: Colors.orange,
                                    ),
                                  );
                                }
                              }
                              return const Icon(
                                Icons.file_copy_outlined,
                                size: 100,
                                color: Colors.orange,
                              );
                            }),
                        Text(
                          _folders![index].path.split('/').last,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        _showDeleteDialog(index);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: _folders!.length,
        ),
      ),
    );
  }

  Future<FileStat> getFileType(file) {
    return file.stat();
  }
}
