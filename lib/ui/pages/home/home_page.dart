import 'package:flutter/material.dart';
import 'UserData/ColoredBlockWidget.dart';
import 'Brainwave Widget/Brainwave.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Home'),
      ),
      backgroundColor: Color(0xFFE4EEFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBlockWidget(), // Đưa ColoredBlockWidget lên đầu
          SizedBox(
              width: MediaQuery.of(context).size.width /5), // Khoảng trống bên phải chiếm 1/5 màn hình

          // Add the Brainwave widget here
          Brainwave(),

          // New widget with two columns and divider
          SizedBox(height: 20), // Add some spacing between the Brainwave widget and the new widget
          // New widget with two columns and divider
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(10), // Add rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.open_in_new, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Bạn đã lái xe được 8 tiếng',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider( // Add a divider with height 1
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.open_in_new, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Bạn cần nghỉ ngơi',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}