import 'package:bloc/bloc.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

import '../../services/mindlink_data_analyzer.dart';
import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import 'graph_data_state.dart';

class GraphDataCubit extends Cubit<GraphDataState> {
  GraphDataCubit() : super(GraphDataInitial());

  bool _isListening = false;
  late Stream<MindLinkData> dataStream;

  void subscribeData(BluetoothDeviceInfo device, {BluetoothConnection? classicConnection}) {
    if (!_isListening) {
      _isListening = true;
      final MindLinkDataAnalyzer analyzer = MindLinkDataAnalyzer();
      classicConnection?.input?.listen(
        (data) {
          dataStream = analyzer.analyze(data);
          dataStream.listen(
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
