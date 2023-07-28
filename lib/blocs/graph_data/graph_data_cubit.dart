import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

import '../../services/mindlink_data_analyzer.dart';
import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import 'graph_data_state.dart';

class GraphDataCubit extends Cubit<GraphDataState> {
  GraphDataCubit() : super(GraphDataInitial());

  bool _isListening = false;
  final StreamController<MindLinkData> _dataStreamController = StreamController<MindLinkData>();

  Stream<MindLinkData> get dataStream => _dataStreamController.stream;

  Stream<MindLinkData> _generateData() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      yield MindLinkData(
        poorQuality: Random(DateTime.now().millisecondsSinceEpoch % 23).nextInt(10) + 1,
        attention: Random(DateTime.now().millisecondsSinceEpoch % 31).nextInt(100) + 1,
        meditation: Random(DateTime.now().millisecondsSinceEpoch % 47).nextInt(100) + 1,
      );
    }
  }

  void mockData() {
    _dataStreamController.addStream(_generateData());
    _dataStreamController.stream.listen(
      (event) {
        emit(GraphDataAdded(data: event));
      },
      onDone: () {
        // ignore
      },
      onError: (e, s) {
        // ignore
      },
      cancelOnError: true,
    );
  }

  void subscribeData(BluetoothDeviceInfo device, {BluetoothConnection? classicConnection}) {
    if (!_isListening) {
      _isListening = true;
      final MindLinkDataAnalyzer analyzer = MindLinkDataAnalyzer();
      classicConnection?.input?.listen(
        (data) {
          analyzer.analyze(data).listen(
            (event) {
              emit(GraphDataAdded(data: event));
              _dataStreamController.add(event);
            },
            onDone: () {
              // ignore
            },
            onError: (e, s) {
              // ignore
            },
            cancelOnError: true,
          );
        },
        onDone: () {
          _isListening = false;
        },
        onError: (e, s) {
          _isListening = false;
        },
        cancelOnError: true,
      );
    }
  }
}
