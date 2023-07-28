import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../services/mindlink_data_analyzer.dart';

class MindLinkDataGraph extends StatefulWidget {
  const MindLinkDataGraph({Key? key, required this.mindLinkDataStream})
      : super(key: key);
  final Stream<MindLinkData>? mindLinkDataStream;

  @override
  State<MindLinkDataGraph> createState() => _MindLinkDataGraphState();
}

class _MindLinkDataGraphState extends State<MindLinkDataGraph> {
  List<double> attentionData = [];
  List<double> meditationData = [];

  @override
  void initState() {
    super.initState();
    if (widget.mindLinkDataStream == null) {
      print('Mindlink data received error');
    }
    widget.mindLinkDataStream?.listen((data) {
      setState(() {
        // Check and remove the first elements if lists reach 500 values
        if (attentionData.length >= 500) {
          attentionData.removeAt(0);
        }
        if (meditationData.length >= 500) {
          meditationData.removeAt(0);
        }

        attentionData.add(data.attention.toDouble());
        meditationData.add(data.meditation.toDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 500,
          minY: 0,
          maxY: 100, // Assuming attention and meditation range from 0 to 100
          lineBarsData: [
            LineChartBarData(
              spots: attentionData.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
              isCurved: true,
              color: Color.fromRGBO(238, 30, 30, 50), // Red color for attention line
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
            LineChartBarData(
              spots: meditationData.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
              isCurved: true,
              color: Color.fromRGBO(0, 128, 255, 50) , // Blue color for meditation line
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
