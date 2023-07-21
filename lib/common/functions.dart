import 'package:flutter/services.dart';

Future<void> exitApp(Duration duration) async {
  // only for android
  Future.delayed(duration, () {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  });
}
