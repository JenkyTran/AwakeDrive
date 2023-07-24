import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

part 'bluetooth_device_connect_state.dart';

class BluetoothDeviceConnectCubit extends Cubit<BluetoothDeviceConnectState> {
  BluetoothDeviceConnectCubit() : super(BluetoothDeviceConnectInitial());
  final List<BluetoothDeviceInfo> connectedDevices = [];

  void connect(BluetoothDeviceInfo deviceInfo) {

  }
}
