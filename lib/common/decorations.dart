import 'package:flutter/material.dart';

import 'colors.dart';

class Decorations {
  static const homeScaffoldDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(143, 143, 143, 0.10),
        offset: Offset(0, 4),
        blurRadius: 60,
      ),
      BoxShadow(
        color: Color.fromRGBO(184, 184, 184, 0.20),
        blurRadius: 2,
      ),
    ],
    gradient: Gradients.homeScaffoldGradient
  );
}
