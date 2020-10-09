import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xbuy/pages/details.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras = [];
  CameraScreen({Key key, this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState(cameras);
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  _CameraScreenState(this.cameras);

  CameraController _controller;

  @override
  void initState() {
    super.initState();
    print(cameras);
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> _takePicture() async {
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    // Formatting Date and Time
    String dateTime = DateFormat.yMMMd()
        .addPattern('-')
        .add_Hms()
        .format(DateTime.now())
        .toString();

    String formattedDateTime = dateTime.replaceAll(' ', '');
    print("Formatted: $formattedDateTime");

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String visionDir = '${appDocDir.path}/Photos/xbuy';
    await Directory(visionDir).create(recursive: true);
    final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

    if (_controller.value.isTakingPicture) {
      print("Processing is progress ...");
      return null;
    }

    try {
      await _controller.takePicture(imagePath);
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }

    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Xbuy "),
        ),
        body: _controller.value.isInitialized
            ? Stack(
                children: <Widget>[
                  CameraPreview(_controller),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera),
                        label: Text("Click"),
                        onPressed: () async {
                          await _takePicture().then((String path) {
                            if (path != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(path),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              )
            : Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
