import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class EEGGraphWidget extends StatefulWidget {
  @override
  _EEGGraphWidgetState createState() => _EEGGraphWidgetState();
}

class _EEGGraphWidgetState extends State<EEGGraphWidget> {
  List<EEGData> data = [];

  Future<void> _fetchData() async {
  final String jsonData = await rootBundle.loadString('assets/data/EEGraw-1.txt');
  final List<dynamic> jsonList = json.decode(jsonData);

  setState(() {
    data = jsonList.map((item) => EEGData.fromJson(item)).toList();
    print('Data loaded: $data'); // Add this line to print the loaded data
  });
}


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EEG Graph'),
      ),
      body: charts.LineChart(
        _createSampleData(),
        animate: true,
      ),
    );
  }

  List<charts.Series<EEGData, num>> _createSampleData() {
    return [
      charts.Series<EEGData, num>(
        id: 'EEG',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EEGData eegData, _) => eegData.index as num,
        measureFn: (EEGData eegData, _) => eegData.value,
        data: data,
      ),
    ];
  }
}

class EEGData {
  final num index;
  final double value;

  EEGData({required this.index, required this.value});

  factory EEGData.fromJson(Map<String, dynamic> json) {
    return EEGData(
      index: json['index'] ?? 0, // Provide a default value for index
      value: json['value'],
    );
  }
}
