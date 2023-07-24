import 'package:bloc/bloc.dart';
import 'package:bluetooth_manager/bluetooth_manager.dart';
import 'package:bluetooth_manager/models/bluetooth_models.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';

part 'bluetooth_connection_state.dart';

class BluetoothConnectionCubit extends Cubit<BluetoothConnectionState> {
  BluetoothConnectionCubit() : super(BluetoothConnectionInitial());

  void subscribeBluetoothStatus() {
    GetIt.I<BluetoothManager>().getBluetoothStateStream().listen(
      (event) {
        switch (event) {
          case BluetoothState.on:
            emit(BluetoothReady());
            break;
          case BluetoothState.off:
          case BluetoothState.uknow:
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
}
