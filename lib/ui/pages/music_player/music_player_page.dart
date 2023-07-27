// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class MusicPlayerScreen extends StatefulWidget {
  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer
        .dispose(); // Remember to dispose of the audio player when no longer needed.
    super.dispose();
  }

 void playSound() async {
    String path = 'assets/sound.mp3';

    // Load the audio data from the asset
    ByteData data = await rootBundle.load(path);

    // Play the audio from the asset
    await audioPlayer.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 238, 255, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Nửa trên màn hình với ảnh gif và vòng tròn bao quanh
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 40.0, bottom: 20.0), // Lùi nhóm xuống vị trí center
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromRGBO(115, 104, 239, 0.4),
                          width: 16.0,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.3,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromRGBO(115, 104, 239, 0.4),
                            width: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.3,
                      child: Container(
                        width: 320,
                        height: 320,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromRGBO(115, 104, 239, 0.4),
                            width: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/image1.png', // Thay đổi đường dẫn ảnh gif của bạn ở đây
                      width: 200, // Điều chỉnh kích thước của ảnh gif
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Nửa dưới màn hình với Text và Button
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your sound',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Change music sound',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => playSound(),
                  icon: Icon(Icons.play_arrow),
                  label: Text(
                    'Play',
                    style: TextStyle(fontSize: 24),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200, 60)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
