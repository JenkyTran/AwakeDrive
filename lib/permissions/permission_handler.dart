import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> requestPermission() async {
    if (await Permission.bluetooth.request().isDenied) {
      return false;
    }
    if (await Permission.bluetoothAdvertise.request().isDenied) {
      return false;
    }
    if (await Permission.bluetoothScan.request().isDenied) {
      return false;
    }
    if (await Permission.bluetoothConnect.request().isDenied) {
      return false;
    }
    if (await Permission.location.request().isDenied) {
      if (!await Permission.location.shouldShowRequestRationale) {
        return false;
      }
    }
    return true;
  }
}
