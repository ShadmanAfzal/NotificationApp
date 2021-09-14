import 'dart:html';

import 'package:flutter/material.dart';
import 'package:permission/Components/permissionTiles.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool fileSystem = false;
  bool camera = false;
  bool location = false;
  bool bluetooth = false;
  bool sms = false;
  bool voiceInput = false;
  bool notification = false;
  Map<Permission, PermissionStatus> statuses = {};

  @override
  void initState() {
    askedForPermission();
    super.initState();
  }

  askedForPermission() async {
    statuses = await [
      Permission.location,
      Permission.camera,
      Permission.sms,
      Permission.bluetooth,
      Permission.notification,
      Permission.storage,
      Permission.microphone
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Test App"),
      ),
      body: Column(
        children: [
          Text("Permission Allowed"),
          permissionTiles(
              statuses[Permission.storage]?.isDenied ?? false, "File System"),
          permissionTiles(
              statuses[Permission.camera]?.isDenied ?? false, "Camera"),
          permissionTiles(
              statuses[Permission.location]?.isDenied ?? false, "Location"),
          permissionTiles(
              statuses[Permission.bluetooth]?.isDenied ?? false, "Bluetooth"),
          permissionTiles(statuses[Permission.sms]?.isDenied ?? false, "SMS"),
          permissionTiles(statuses[Permission.microphone]?.isDenied ?? false,
              "Voice Input"),
          permissionTiles(statuses[Permission.notification]?.isDenied ?? false,
              "Notification"),
        ],
      ),
    );
  }
}
