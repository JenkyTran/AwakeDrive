import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../bluetooth_device_connect/bluetooth_device_connect_cubit.dart';
import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

part 'bluetooth_devices_connect_state.dart';

class BluetoothDevicesConnectCubit extends Cubit<BluetoothDevicesConnectState> {
  BluetoothDevicesConnectCubit() : super(BluetoothDevicesConnectInitial());
  final Map<BluetoothDeviceConnectState, BluetoothDeviceInfo> devices = {};
}
