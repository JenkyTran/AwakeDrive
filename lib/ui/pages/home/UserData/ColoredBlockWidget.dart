
import 'user_data.dart';
import 'user_model.dart';
import 'package:flutter/material.dart';

class ColoredBlockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy thông tin user đầu tiên từ danh sách
    UserModel user = usersData.first;

    return Container(
      width: 352,
      height: 133,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(38, 205, 255, 1),
            Color.fromRGBO(4, 236, 222, 1),
            Color.fromRGBO(47, 213, 218, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: (133 - 80) / 2,
            left: 8,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
          ),
          Positioned(
            top: 8 + (133 - 80) / 2,
            left: 100,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${user.name}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date of Birth: ${user.dob}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Hometown: ${user.hometown}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
