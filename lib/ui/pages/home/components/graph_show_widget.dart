import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../blocs/graph_data/graph_data_cubit.dart';
import '../../../../blocs/graph_data/graph_data_state.dart';

class MindLinkDataGraph extends StatefulWidget {
  const MindLinkDataGraph({Key? key}) : super(key: key);

  @override
  State<MindLinkDataGraph> createState() => _MindLinkDataGraphState();
}

class _MindLinkDataGraphState extends State<MindLinkDataGraph> {
  List<double> attentionData = [];
  List<double> meditationData = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphDataCubit, GraphDataState>(
      builder: (context, state) {
        if (state is GraphDataAdded) {
          // Check and remove the first elements if lists reach 500 values
          if (attentionData.length >= 50) {
            attentionData.removeAt(0);
          }
          if (meditationData.length >= 50) {
            meditationData.removeAt(0);
          }
          attentionData.add(state.data.attention.toDouble());
          meditationData.add(state.data.meditation.toDouble());
        }
        return LineChart(
          duration: Duration.zero,
          curve: Curves.easeIn,
          LineChartData(
            // gridData: const FlGridData(show: true),
            // titlesData: const FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            minX: 0,
            maxX: 30,
            minY: 0,
            maxY: 120,
            gridData: FlGridData(
              // checkToShowHorizontalLine: (v) => v % 20 == 0,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (v) => FlLine(
                color: Colors.blueGrey.withAlpha(64),
                dashArray: [5, 10],
                strokeWidth: 1,
              ),
              horizontalInterval: 20,
            ),
            clipData: const FlClipData.all(),
            titlesData: const FlTitlesData(
              topTitles: AxisTitles(axisNameWidget: SizedBox()),
              rightTitles: AxisTitles(axisNameWidget: SizedBox()),
            ),
            // Assuming attention and meditation range from 0 to 100
            lineBarsData: [
              LineChartBarData(
                spots: attentionData.asMap().entries.map((entry) {
                  return FlSpot(entry.key.toDouble(), entry.value);
                }).toList(),
                isCurved: true,
                color: const Color.fromRGBO(238, 30, 30, 50),
                // Red color for attention line
                belowBarData: BarAreaData(),
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: meditationData.asMap().entries.map((entry) {
                  return FlSpot(entry.key.toDouble(), entry.value);
                }).toList(),
                isCurved: true,
                color: const Color.fromRGBO(0, 128, 255, 50),
                // Blue color for meditation line
                belowBarData: BarAreaData(),
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        );
      },
    ).pOnly(bottom: 30, top: 30);
  }
}
