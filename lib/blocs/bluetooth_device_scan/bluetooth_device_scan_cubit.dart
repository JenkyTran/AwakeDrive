import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nb_utils/nb_utils.dart';

part 'bluetooth_device_scan_state.dart';

class BluetoothDeviceScanCubit extends Cubit<BluetoothDeviceScanState> {
  BluetoothDeviceScanCubit() : super(BluetoothDeviceScanInitial());

  void subscribeBluetoothDevicesScan() {
    FlutterBluePlus.instance.scanResults.listen(
      (event) {
        //
      },
      onError: (err, stackTrace) {
        log('$err; $stackTrace');
        emit(BluetoothDeviceScanError());
      },
      onDone: () {
        emit(BluetoothDeviceScanStopped());
        log('Bluetooth stream done');
      },
      cancelOnError: true,
    );
  }

  void startScan() {
    emit(BluetoothDeviceScanning());
    FlutterBluePlus.instance.startScan(timeout: const Duration(minutes: 1)).whenComplete(() => emit(BluetoothDeviceScanStopped()));
  }

  void stopScan() {
    FlutterBluePlus.instance.stopScan().whenComplete(() => emit(BluetoothDeviceScanStopped()));
  }
}
