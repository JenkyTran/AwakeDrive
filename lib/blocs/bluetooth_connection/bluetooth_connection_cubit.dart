import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nb_utils/nb_utils.dart';

part 'bluetooth_connection_state.dart';

class BluetoothConnectionCubit extends Cubit<BluetoothConnectionState> {
  BluetoothConnectionCubit() : super(BluetoothConnectionInitial());

  void subscribeBluetoothStatus() {
    FlutterBluePlus.instance.adapterState.listen(
      (event) {
        switch (event) {
          case BluetoothAdapterState.on:
            emit(BluetoothReady());
            break;
          case BluetoothAdapterState.off:
          case BluetoothAdapterState.unknown:
          case BluetoothAdapterState.unauthorized:
          case BluetoothAdapterState.turningOff:
          case BluetoothAdapterState.turningOn:
          case BluetoothAdapterState.unavailable:
          default:
            emit(BluetoothUnavailable());
            break;
        }
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
