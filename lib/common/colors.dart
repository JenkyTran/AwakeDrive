import 'package:flutter/material.dart';

class Gradients {
  static const homeScaffoldGradient = LinearGradient(
    begin: Alignment(0.9, 0.9),
    end: Alignment(-0.9, -0.9),
    stops: [0, 0.1667, 0.33333, 0.6, 0.5854, 0.6167, 0.6667, 0.6668, 0.8883, 0.9031, 1],
    colors: [
      Color(0xFF09899B),
      Color(0xFFABCDBA),
      Color(0xFF16B5AC),
      Color(0xFF2FD5DA),
      Color(0xFF2BD1ED),
      Color(0xFF29D0F4),
      Color(0xFF26CDFF),
      Color(0xFF27C2FA),
      Color(0xFF5387EC),
      Color.fromRGBO(111, 146, 237, 0.90),
      Color(0xFF136B98),
    ],
  );
}

class Colors {

}
