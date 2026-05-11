import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class SimReader {

  static const MethodChannel _channel = MethodChannel("sim_reader");

  static Future<List<dynamic>> getSimNumbers() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
     return await _channel.invokeMethod("getSimNumbers");

    } else {

      print("Permission Denied");
    }


    return [];
  }

  static Future<bool> allowPermission() async
  {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {

      return true;
    }
    else{
      return false;
    }
  }
}