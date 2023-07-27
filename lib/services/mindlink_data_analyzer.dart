import 'dart:typed_data';

import 'package:get_it/get_it.dart';

import '../common/errors.dart';

class MindLinkData {
  MindLinkData({required this.poorQuality, required this.attention, required this.meditation, required this.rawData});

  final int poorQuality;
  final int attention;
  final int meditation;
  final int rawData;
}

class MindLinkDataAnalyzer {
  List<List<int>> _capturePayload(Uint8List data) {
    final List<List<int>> returnData = [];
    int count170 = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i] == 170) {
        count170 += 1;
        continue;
      } else {
        if (count170 != 2) {
          count170 = 0;
        }
      }
      if (count170 == 2) {
        count170 = 0;
        final int payloadLength = data[i];
        throwIf(payloadLength > 169, MindLinkDataError('Payload length can not be greater than 169'));
        final List<int> payloadData = [];
        final int checkSum = data[i + payloadLength + 1];
        int check = 0;
        for (int j = i + 1; j <= i + payloadLength; j++) {
          payloadData.add(data[j]);
          check += data[j];
        }
        // if (255 - checkSum != check) {
        //   continue;
        // }
        returnData.add(payloadData);
        i = i + payloadLength + 1;
      }
    }
    return returnData;
  }

  Stream<MindLinkData> analyze(Uint8List data) async* {
    for (final listData in _capturePayload(data)) {
      int poorQuality = 200;
      int attention = 0;
      int meditation = 0;
      int rawData = 0;
      bool skip = false;
      for (int i = 0; i < listData.length; i++) {
        switch (listData[i]) {
          case 2:
            i++;
            poorQuality = listData[i];
            // bigPacket = true
            break;
          case 4:
            i++;
            attention = listData[i];
            break;
          case 5:
            i++;
            meditation = listData[i];
            break;
          case 128:
            // i++;
            // rawData = (listData[i + 1] << 8) | listData[i + 2];
            skip = true;
            break;
          case 131:
            // analyze 8 factor of brain wave
            skip = true;
            break;
          default:
            skip = true;
            break;
        }
        // skip all below data (case 131 and default)
        break;
      }
      if (skip) {
        continue;
      }
      yield MindLinkData(poorQuality: poorQuality, attention: attention, meditation: meditation, rawData: rawData);
    }
  }
}
