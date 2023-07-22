import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nb_utils/nb_utils.dart';

part 'bluetooth_device_scan_state.dart';

class BluetoothDeviceConnectCubit extends Cubit<BluetoothDeviceScanState> {
  BluetoothDeviceConnectCubit() : super(BluetoothDeviceScanInitial());

  void subscribeBluetoothDevicesScan() {
    FlutterBluePlus.instance.scanResults.listen(
      (event) {
        //
      },
      onError: (err, stackTrace) {
        log('$err; $stackTrace');
      },
      onDone: () {
        log('Bluetooth stream done');
      },
      cancelOnError: false,
    );
  }

  void startScan() {
    FlutterBluePlus.instance.startScan(timeout: const Duration(minutes: 5));
  }

  void stopScan() {
    FlutterBluePlus.instance.stopScan();
  }
}
