import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../services/mindlink_data_analyzer.dart';

class MindLinkDataGraph extends StatefulWidget {
  final Stream<MindLinkData> mindLinkDataStream;

  const MindLinkDataGraph({Key? key, required this.mindLinkDataStream})
      : super(key: key);

  @override
  State<MindLinkDataGraph> createState() => _MindLinkDataGraphState();
}

class _MindLinkDataGraphState extends State<MindLinkDataGraph> {
  List<double> attentionData = [];
  List<double> meditationData = [];

  @override
  void initState() {
    super.initState();
    widget.mindLinkDataStream.listen((data) {
      setState(() {
        attentionData.add(data.attention.toDouble());
        meditationData.add(data.meditation.toDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MindLinkDataChartPainter(
          attentionData: attentionData,
          meditationData: meditationData,
        ),
      ),
    );
  }
}

class MindLinkDataChartPainter extends CustomPainter {
  final List<double> attentionData;
  final List<double> meditationData;

  MindLinkDataChartPainter(
      {required this.attentionData, required this.meditationData});

  @override
  void paint(Canvas canvas, Size size) {
    double maxValue = attentionData.reduce(max);
    if (maxValue < meditationData.reduce(max)) {
      maxValue = meditationData.reduce(max);
    }
    double xStep = size.width / (attentionData.length - 1);
    double yStep = size.height / maxValue;

    Paint attentionPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;
    Paint meditationPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    for (int i = 0; i < attentionData.length; i++) {
      double x = i * xStep;
      double y = attentionData[i] * yStep;
      canvas.drawLine(Offset(x, 0.0), Offset(x, y), attentionPaint);
    }

    for (int i = 0; i < meditationData.length; i++) {
      double x = i * xStep;
      double y = meditationData[i] * yStep;
      canvas.drawLine(Offset(x, 0.0), Offset(x, y), meditationPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}