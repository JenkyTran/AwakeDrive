import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.back_hand)],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Demo',

        ),
      ),
    );
  }
}
