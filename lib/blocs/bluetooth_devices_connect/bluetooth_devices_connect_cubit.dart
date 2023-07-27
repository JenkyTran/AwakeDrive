import 'package:bloc/bloc.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

import '../bluetooth_device_connect/bluetooth_device_connect_cubit.dart';
import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

part 'bluetooth_devices_connect_state.dart';

class BluetoothDevicesConnectCubit extends Cubit<BluetoothDevicesConnectState> {
  BluetoothDevicesConnectCubit() : super(BluetoothDevicesConnectInitial());
  final List<BluetoothDeviceInfo> devices = [];
  final Map<String, BluetoothDeviceConnectState> mapStates = {};
  final Map<String, BluetoothConnection> classicConnections = {};
  
  void add(BluetoothDeviceInfo device, BluetoothDeviceConnectState state, {BluetoothConnection? classicConnection}) {
    if (devices.filter((element) => element.id == state.device!.id).isEmpty) {
      devices.add(state.device!);
      mapStates[device.id] = state;
      if (classicConnection != null) {
        classicConnections[device.id] = classicConnection;
      }
    }
    emit(BluetoothDeviceAdded(device: device));
  }
  
  void remove(BluetoothDeviceInfo device) {
    devices.removeWhere((element) => element.id == device.id);
    mapStates.removeWhere((key, value) => key == device.id);
    classicConnections.removeWhere((key, value) => key == device.id);
    emit(BluetoothDeviceAdded(device: device));
  }
}
