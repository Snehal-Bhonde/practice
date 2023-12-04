import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

  @override
  void initState() {
    super.initState();
    checkMultiplePermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    GestureDetector(
        onTap: (){
          //requestPermissions();
          },
        child: Center(child: const Text("Permission Handling"))));
  }

  Future checkMultiplePermissions() async {
    // List of permissions to check
    List<Permission> permissions = [
      Permission.camera,
      Permission.photos,
      Permission.location,
      // Add more permissions as needed
    ];

    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.location,
    ].request();

    statuses.forEach((permission, status) {
      print("$permission $status");
    });

  }

  // void requestPermissions() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.camera,
  //     //Permission.storage,
  //     Permission.location,
  //     Permission.notification
  //   ].request();
  //
  //   statuses.forEach((permission, status) {
  //     // if (!status.isGranted) {
  //     print("$permission $status");
  //     // }
  //   });
  // }


}
