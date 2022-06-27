import 'package:file_app_icanio/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showBottomMenu(
  BuildContext context,
  String screenName,
  String folderName,
) {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? getMediaList;
  XFile? pickVideo;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    builder: (context) {
      return SizedBox(
        height: 200,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.photo,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Choose Image From Gallery",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.0,
                ),
              ),
              onTap: () async {
                getMediaList = await _imagePicker.pickMultiImage(
                  maxWidth: 200.0,
                  maxHeight: 200.0,
                );
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  "/image",
                  arguments: {
                    "mediaList": getMediaList!,
                    "screen": screenName,
                    "folderName": folderName,
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.video_collection_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Choose Video From Gallery",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.0,
                ),
              ),
              onTap: () async {
                pickVideo = await _imagePicker.pickVideo(
                  source: ImageSource.gallery,
                );
                Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoScreen(
                      videoFilePath: pickVideo!,
                      screen: screenName,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.folder,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Create Folder",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/folder");
              },
            ),
          ],
        ),
      );
    },
  );
}
