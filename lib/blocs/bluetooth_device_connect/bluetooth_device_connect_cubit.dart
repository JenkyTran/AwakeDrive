import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

part 'bluetooth_device_connect_state.dart';

class BluetoothDeviceConnectCubit extends Cubit<BluetoothDeviceConnectState> {
  BluetoothDeviceConnectCubit() : super(BluetoothDeviceConnectInitial());
  final List<BluetoothDeviceInfo> connectedDevices = [];

  Future<void> connect(BluetoothDeviceInfo deviceInfo) async {
    emit(BluetoothDeviceConnecting(device: deviceInfo));
    if (deviceInfo.scannedBleDevice != null) {
      if (Platform.isAndroid) {
        await deviceInfo.scannedBleDevice!.device.pair();
      }
      await deviceInfo.scannedBleDevice!.device.connect(
        timeout: const Duration(seconds: 30),
        autoConnect: true,
      );
      if ((await FlutterBluePlus.connectedDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceConnected(device: deviceInfo));
      } else {
        emit(BluetoothDeviceConnectError(device: deviceInfo));
      }
    } else {
      if (await FlutterBluetoothSerial.instance.bondDeviceAtAddress(deviceInfo.address) ?? false) {
        // todo
      } else {
        emit(BluetoothDeviceConnectError(device: deviceInfo));
      }
    }
  }

  Future<void> disconnect(BluetoothDeviceInfo deviceInfo) async {
    emit(BluetoothDeviceDisconnecting(device: deviceInfo));
    if (deviceInfo.scannedBleDevice != null) {
      if (!(await FlutterBluePlus.connectedDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceDisconnected(device: deviceInfo));
      }
      await deviceInfo.scannedBleDevice!.device.disconnect();
      if (!(await FlutterBluePlus.connectedDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceDisconnected(device: deviceInfo));
      } else {
        emit(BluetoothDeviceDisconnectError(device: deviceInfo));
      }
    } else {

    }
  }

  void subscribeBleDeviceConnectionState(BluetoothDeviceInfo deviceInfo) {
    deviceInfo.scannedBleDevice!.device.connectionState.listen((event) {});
  }
}
